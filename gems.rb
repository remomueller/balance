# frozen_string_literal: true

# rubocop:disable Layout/ExtraSpacing
source "https://rubygems.org"

gem "rails",                      "6.0.3.4"

# PostgreSQL as the Active Record database.
gem "pg",                         "1.1.4"

# Gems used by project.
gem "autoprefixer-rails"
gem "bootstrap",                  "~> 4.4.1"
gem "devise",                     "~> 4.7.3"
gem "figaro",                     "~> 1.2.0"
gem "font-awesome-sass",          "~> 5.12.0"
gem "haml",                       "~> 5.0.4"
gem "jquery-ui-rails",            "~> 6.0.1"
gem "kaminari",                   "~> 1.1.1"

# Rails defaults
gem "coffee-rails",            "~> 5.0"
gem "jbuilder",                "~> 2.9"
gem "jquery-rails",            "~> 4.3.5"
gem "puma",                    "~> 3.11"
gem "redis",                   "~> 4.0"
gem "sass-rails",              "~> 5"
gem "turbolinks",              "~> 5"
gem "uglifier",                ">= 1.3.0"

group :development do
  gem "listen",                   ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen",    "~> 2.0.0"
  gem "web-console",              ">= 3.3.0"
end

group :test do
  gem "capybara",                 ">= 2.15", "< 4.0"
  gem "minitest"
  gem "selenium-webdriver"
  gem "simplecov",                "~> 0.16.1", require: false
end
# rubocop:enable Layout/ExtraSpacing
