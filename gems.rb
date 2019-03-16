# frozen_string_literal: true

# rubocop:disable Layout/ExtraSpacing
source "https://rubygems.org"

gem "rails",                      "6.0.0.beta3"

# PostgreSQL as the Active Record database.
gem "pg",                         "1.1.4"

# Gems used by project.
gem "autoprefixer-rails"
gem "bootstrap",                  "~> 4.3.1"
gem "devise",                     "~> 4.6.1"
gem "figaro",                     "~> 1.1.1"
gem "font-awesome-sass",          "~> 5.6.1"
gem "haml",                       "~> 5.0.4"
gem "jquery-ui-rails",            "~> 6.0.1"
gem "kaminari",                   "~> 1.1.1"

# Rails defaults.
gem "coffee-rails",               "~> 4.2"
gem "sass-rails",                 "~> 5.0"
gem "uglifier",                   ">= 1.3.0"

gem "jbuilder",                   "~> 2.5"
gem "jquery-rails",               "~> 4.3.3"
gem "turbolinks",                 "~> 5"

group :development do
  gem "listen",                   ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen",    "~> 2.0.0"
  gem "web-console",              ">= 3.3.0"
end

group :test do
  gem "capybara",                 ">= 2.15", "< 4.0"
  gem "minitest"
  gem "puma"
  gem "selenium-webdriver"
  gem "simplecov",                "~> 0.16.1", require: false
end
# rubocop:enable Layout/ExtraSpacing
