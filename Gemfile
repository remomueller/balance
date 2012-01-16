source 'http://rubygems.org'

gem 'rails', '3.2.0.rc2'

# Database Adapter
gem 'mysql2',         '0.3.11'
gem 'thin',           '~> 1.3.1',           platforms: [ :mswin, :mingw ]
gem 'eventmachine',   '~> 1.0.0.beta.4.1',  platforms: [ :mswin, :mingw ]

# Gems used by project
gem 'contour',        '~> 0.9.0'            # Basic Layout and Assets
gem 'kaminari'                              # Pagination

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'            # Compiles CSS
  gem 'coffee-rails', '~> 3.2.0'            # Compiles JavaScript
  gem 'uglifier',     '>= 1.0.3'            # Minimizes and obscures JS and CSS
end

gem 'jquery-rails'                          # JavaScript Engine

# Testing
group :test do
  # Pretty printed test output
  gem 'win32console',                       platforms: [ :mswin, :mingw ]
  gem 'turn',         '~> 0.8.3',           require: false
  gem 'simplecov',                          require: false
end
