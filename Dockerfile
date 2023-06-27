FROM ruby
COPY . /app
WORKDIR /app
CMD ruby lib/runner.rb