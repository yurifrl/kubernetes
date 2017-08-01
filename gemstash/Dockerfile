#
FROM ruby

#
ADD Gemfile /app/Gemfile
WORKDIR /app

#
RUN bundle install

#
ADD config.yml /app/config.yml

#
CMD bundle exec gemstash start --no-daemonize --config-file config.yml
