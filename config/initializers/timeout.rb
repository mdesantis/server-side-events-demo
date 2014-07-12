# Needed because Puma app server has not timeout configuration
# See https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#timeout
Rack::Timeout.timeout = 20  # seconds