FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /myapp
COPY ./backend/Gemfile /myapp/Gemfile
COPY ./backend/Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./backend /myapp
COPY ./backend/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
