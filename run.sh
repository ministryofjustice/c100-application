#!/bin/sh

set -o errexit
set -o nounset

sed -i 's/LocalSocketGroup clamav/LocalSocketGroup appgroup/g' /etc/clamav/clamd.conf
clamd

cd /usr/src/app 2> /dev/null

bundle exec rake db:migrate
bundle exec pumactl -F config/puma.rb start
