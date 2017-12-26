# frozen_string_literal: true

source "https://rubygems.org"

gem "rails",                "5.2.0.beta2"

# Speed Up Loading Times
gem "bootsnap",             "1.1.7", require: false

# Database Adapter
gem "pg",                   "0.21.0"

# Gems used by project
gem "autoprefixer-rails"
gem "bootstrap",            "~> 4.0.0.beta2"
gem "colorize",             "~> 0.8.1"
# gem "devise",               "~> 4.3.0"
gem "devise", git: "https://github.com/plataformatec/devise", ref: "135d898"
gem "figaro",               "~> 1.1.1"
gem "font-awesome-rails",   "~> 4.7.0"
gem "haml",                 "~> 5.0.4"
gem "jquery-ui-rails",      "~> 6.0.1"
gem "kaminari",             "~> 1.1.1"

# Rails Defaults
gem "coffee-rails",         "~> 4.2"
gem "sass-rails",           "~> 5.0"
gem "uglifier",             ">= 1.3.0"

gem "jbuilder",             "~> 2.0"
gem "jquery-rails",         "~> 4.3.1"
gem "turbolinks",           "~> 5"

# Testing
group :test do
  gem "minitest"
  gem "rails-controller-testing"
  gem "simplecov", "~> 0.15.1", require: false
end

group :development do
  gem "web-console", "~> 3.0"
end
