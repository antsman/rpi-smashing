FROM hypriot/rpi-alpine

ENV RUN_PACKAGES ruby nodejs
ENV BUILD_PACKAGES build-base ruby-dev subversion

# User, home (app) and data folders
ENV USER smashing
ENV HOME /usr/src/$USER
ENV DATA /data

# Put gems and bin under home
ENV BUNDLE_PATH $HOME/gems
ENV BUNDLE_BIN $HOME/bin
ENV PATH $PATH:$BUNDLE_BIN

# Update index, install dependencies
RUN apk update && apk upgrade && \
    apk add $RUN_PACKAGES && \
    apk add $BUILD_PACKAGES && \
    \
# Install bundler
    mkdir -p $HOME && \
    echo 'gem: --no-document' >> ~/.gemrc && \
    gem install bundler && \
    \
# Clone sample project as $DATA folder, add gems required
    svn export https://github.com/Smashing/smashing/trunk/templates/project $DATA && \
    echo $'\n\n\
gem \'json\'\n\
gem \'io-console\'\n\
gem \'tzinfo-data\'\n\
' >> $DATA/Gemfile && \
    \
# bundle Smashing
    cd $DATA && \
    bundle && \
    \
# Add user so we aren't running as root
    adduser -h $HOME -D -H $USER -g '' && \
    chown -R $USER:$USER $DATA && \
    chown -R $USER:$USER $HOME && \
    \
# Remove build dependencies and clean up
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    find /usr -type d -name test -exec rm -rf {} +

# Smashing startup file, bundle on first start
COPY smashing-start $BUNDLE_BIN

# Smashing service port
EXPOSE 3030

WORKDIR $DATA

USER $USER

ENTRYPOINT ["smashing-start"]
# CMD ["smashing-start"]
