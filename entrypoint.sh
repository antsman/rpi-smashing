#!/bin/sh

# bundle on first start
test -f ~/.bundle_done || (bundle && touch ~/.bundle_done)

# regular startup
exec smashing start
