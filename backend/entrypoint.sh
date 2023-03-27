#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

if [ "$RUN_MIGRATIONS" == "true" ]; then
  echo "Setting up database"
  ./bin/bundle exec rails db:drop
  ./bin/bundle exec rails db:setup
fi;

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
