#
FROM ruby

#
WORKDIR /app

#
COPY Gemfile .

#
COPY config.ru .

#
RUN bundle install

#
ENTRYPOINT ["bundle", "exec", "rackup"]

#
CMD ["--host", "0.0.0.0", "-p", "9292", "-s", "thin", "config.ru"]
