FROM ruby:latest

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update && apt upgrade -y && apt install -y \
  inotify-tools sqlite3 nodejs yarn \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/ruby

EXPOSE 3000

COPY ./entrypoint.sh /usr/src

CMD ["../entrypoint.sh"]
