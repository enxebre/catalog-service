FROM ruby:2.3.1-alpine

RUN apk --update add \
  build-base \
  ruby-dev \
  sqlite-dev

RUN mkdir /usr/app
WORKDIR /usr/app
COPY . /usr/app/

RUN bundle install --without development test
CMD bundle exec rackup -o 0.0.0.0