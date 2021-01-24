## 2.6.0

### Enhancements
- **General Changes**
  - Improve display of backup status pages
- **Gem Changes**
  - Update to ruby 3.0.0
  - Update to rails 6.0.3.4
  - Update to devise 4.7.3
  - Update to bootstrap 4.4.1
  - Update to figaro 1.2.0
  - Update to font-awesome-sass 5.12.0
  - Update to haml 5.2.1
  - Update to kaminari 1.2.1

## 2.5.0 (February 28, 2019)

### Enhancements
- **General Changes**
  - Update interface for setting up accounts, charge types, and templates
  - Improve overview graph year selection
  - Entry dates now link to the appropriate month on the calendar
- **Gem Changes**
  - Update to ruby 2.6.1
  - Update to rails 6.0.0.beta1
  - Update to pg 1.1.4
  - Update to devise 4.6.1
  - Update to bootstrap 4.3.1
  - Update to font-awesome-sass 5.6.1
  - Update to simplecov 0.16.1
  - Remove bootsnap
  - Remove colorize
  - Remove rails-controller-testing

## 2.4.1 (November 16, 2017)

### Enhancements
- **Gem Changes**
  - Updated to ruby 2.4.2
  - Updated `Gemfile` to `gems.rb`
  - Added bootsnap
  - Updated to rails 5.1.4
  - Updated to haml 5.0.4
  - Updated to kaminari 1.1.1
  - Updated to pg 0.21.0
  - Updated to simplecov 0.15.1

### Bug Fix
- Entry tooltips are now properly escaped

### Tests
- Added tests to assure user passwords can be reset

## 2.4.0 (May 20, 2017)

### Enhancements
- **Gem Changes**
  - Updated to rails 5.1.1
  - Updated to devise 4.3.0
  - Updated to haml 5.0.1

## 2.3.1 (April 24, 2017)

### Enhancements
- **Gem Changes**
  - Added autoprefixer-rails

### Bug Fix
- Fixed a bug that did not display the last week for months ending on a Sunday

## 2.3.0 (April 3, 2017)

### Enhancements
- **General Changes**
  - Time of last backup is now tracked
- **Gem Changes**
  - Updated to Ruby 2.4.1
  - Updated to pg 0.20.0
  - Updated to rails 5.0.2
  - Updated to jquery-rails 4.3.1
  - Updated to simplecov 0.14.1

### Bug Fix
- Fixed a bug that reloaded the templates page when removing an item from an
  existing template
- Turbolinks no longer runs ready script twice

### Refactoring
- Refactored controllers and models based on Rubocop recommendations

## 2.2.0 (February 11, 2017)

### Enhancements
- **General Changes**
  - Improved menu title display when scrolling
- **Gem Changes**
  - Updated to Ruby 2.4.0
  - Updated to rails 5.0.1
  - Updated to jquery-rails 4.2.2
  - Updated to jquery-ui-rails 6.0.1
  - Updated to kaminari 1.0.1
  - Updated to simplecov 0.13.0
  - Added font-awesome-rails

## 2.1.0 (November 5, 2016)

### Enhancements
- **General Changes**
  - Extra spaces are now removed when saving names
  - Improved styling across several pages
- **Account Changes**
  - Accounts can now be categorized as "Savings" or "Investments"
  - Current balance page subtotals accounts by category
  - Creating a new account generates a default transfer charge type
- **Charge Type Changes**
  - Charge types are now sorted by account name as well as charge type name
- **Gem Changes**
  - Updated to rails 5.0.0.1
  - Updated to coffee-rails 4.2
  - Updated to jquery-rails 4.2.1
  - Updated to pg 0.19.0

### Bug Fix
- Fixed entry name autocomplete from rendering dropdown multiple times

## 2.0.0 (September 5, 2016)

### Enhancements
- **General Changes**
  - Started rewriting views using haml
  - Added a task to import data from CSVs
    - `rails backup:import FOLDER=20160320173700`
  - Users can backup data from their account
- **Account Changes**
  - Accounts can be archived to hide them on the current balance
- **Entry Changes**
  - Entry description fields now expand automatically to fit longer descriptions
  - Hovering mouse over entries now highlights the entry on the calendar
  - Moving entries on calendar no longer refreshes the entire page
  - Earning and spending graphs now load more quickly
- **Gem Changes**
  - Updated to Ruby 2.3.1
  - Updated to rails 4.2.6
  - Updated to pg 0.18.4
  - Updated to devise 4.2.0
  - Updated to simplecov 0.11.2
  - Updated to jquery-rails 4.1.1
  - Updated to turbolinks 5
  - Updated to kaminari 0.17.0
  - Updated to colorize 0.8.1
  - Updated to simplecov 0.12.0
  - Removed dependency on contour

### Bug Fix
- Fixed a bug that caused double quotes in tooltips to break tooltips

## 1.11.0 (March 26, 2016)

### Enhancements
- **Templates Added**
  - Templates can be created that define a group of entries
  - Templates can be launched from the calendar
- **General Changes**
  - Added a version JSON API
  - Added a task to export data to CSVs
    - `rails data:export`
- **Gem Changes**
  - Use of Ruby 2.3.0 is now recommended
  - Updated to rails 4.2.6
  - Updated to jquery-rails 4.1.1
  - Updated to mysql2 0.4.3
  - Updated to simplecov 0.11.2
  - Updated to web-console 3.0
  - Updated to haml 4.0.7
  - Added colorize
  - Removed minitest-reporters

### Testing
- Added CodeClimate configuration
- Added RuboCop configuration

## 1.10.0 (August 22, 2015)

### Enhancements
- **General Changes**
  - Simplified login routes for devise
- **Gem Changes**
  - Use of Ruby 2.2.3 is now recommended
  - Updated to rails 4.2.3
  - Updated to contour 3.0.1
  - Updated to simplecov 0.10.0
  - Updated to mysql2 0.3.19
  - Updated to kaminari 0.16.3
  - Added web-console
  - Added haml
  - Use Figaro to centralize application configuration

### Refactoring
- Updated asset files to match new Rails file extension naming convention

## 1.9.0 (November 30, 2014)

### Enhancements
- **General Changes**
  - Updated menu bar to highlight commonly used pages
  - Updated the yearly and monthly overview graph
- **Gem Changes**
  - Updated to rails 4.2.0.rc1
  - Updated to contour 2.6.0.beta8
  - Updated to mysql2 0.3.17
  - Updated to kaminari 0.16.1
  - Updated to simplecov 0.9.1
  - Removed turn, and replaced with minitest and minitest-reporters
  - Removed Windows-specific gems
- Enabled turbolinks
- Use of Ruby 2.1.5 is now recommended
- Updated to Highcharts JS 3.0.9
- Updated Google Omniauth to no longer write to disk

## 1.8.1 (February 17, 2013)

### Enhancements
- Clarified filtering on the entries index
- Refactored `account`, `charge_type`, and `entry` models and controllers

### Bug Fix
- Fixed the ordering of Gross Income, Gross Spending, Net Profit for the Earning and Spending Graphs
- Fixed search not working on `accounts` and `charge_types`

## 1.8.0 (February 16, 2013)

### Enhancements
- Entries can now be dragged to a new date on the calendar
- **Gem Changes**
  - Updated to Rails 3.2.12
  - Updated Thin web server to 1.5.0
  - Updated to Contour 1.2.0 and use Contour pagination theme
- Updated to Ruby 1.9.3-p327

### Refactoring
- Added `app/models/concerns`
  - `Searchable`: Allows models to be searched by name
  - `Deletable`: Allows models to be flagged as deleted and scoped by current
- Simplified Overview calculations in `entries_controller.rb`

### Testing
- Updated to SimpleCov 0.7.1

## 1.7.0 (July 4, 2012)

### Enhancements
- Mass-assignment `attr_accessible` and params slicing implemented to leverage Rails 3.2.6 configuration defaults
- Links with `confirm:` now use `data: { confirm: }` to account for deprecations in Rails 4.0
- **Gem Changes**
  - Updated to Contour 1.0.2 and Twitter Bootstrap CSS/JS framework
  - Updated to Rails 3.2.6
- Updating to Ruby 1.9.3-p194

### Bug Fix
- Entries amounts added with dollar signs, commas, and trailing or leading spaces are now correctly parsed (by LisaM)

## 1.6.0 (March 4, 2012)

### Enhancements
- GUI updated to use `contour-minimalist` theme
- **Gem Changes**
  - Updated to Rails 3.2.2 and Contour 0.10.2

## 1.5.1 (February 7, 2012)

### Bug Fix
- Arrow keys no longer change the calendar month when focus is on a text input

## 1.5.0 (February 4, 2012)

### Enhancements
- Entries can now be created from the calendar by double clicking on a date
- **Gem Changes**
  - Updated to Rails 3.2.1 and fixed Devise 2.0.0 locales file

### Bug Fix
- Entry name autocomplete fixed

## 1.4.2 (January 23, 2012)

### Bug Fix
- Devise migrations fixed for Devise 2.0.0

## 1.4.1 (January 23, 2012)

### Enhancements
- Devise migration and configuration file updated
- Environment files updated to be in sync with Rails 3.2.0
- **Gem Changes**
  - Updated to Rails 3.2.0
  - Updated to Contour 0.9.3

## 1.4.0 (January 16, 2012)

### Enhancements
- Updated jQuery Calls to use jQuery 1.7 specification (`.live` to `.on`)
- Removed JavaScript functions that are provided by Contour
- Existing entries can now be copied as templates for new entries
- **Gem Changes**
  - Updated to Rails 3.2.0.rc2
  - Updated to Contour 0.9.0

### Refactoring
- Moved `root_path` to be the entries calendar

### Bug Fix
- Graphs now render correctly in IE7 and IE8
- Autocomplete now works correctly when using a subdomain

### Testing
- Test Coverage is now at 100% with help of SimpleCov
- Continuous integration using TravisCI, [travis-ci.org/remomueller/balance](http://travis-ci.org/remomueller/balance)

## 1.3.0 (October 16, 2011)

### Enhancements
- Changing months now uses jQuery Slide transition on the Month Overview
- Clicking left and right in Month Overview will transition between months
- Current Balance page now lets you calculate your maximum daily spending until your next paycheck (the default day is the beginning of the next month)
- **Gem Changes**
  - Updated to Rails 3.1.1
  - Updated to Contour 0.5.6

## 1.2.0 (August 28, 2011)

### Enhancements
- Major redesign using a better CSS base template (BlueTrip CSS Framework)
- New entries made from calendar are now redirected back to the calendar
- Main dashboard page broken down to Month Overview, Averages, and Current Balance Pages
- Links added for easier navigation to and from accounts and charge types
- Validation errors now correctly highlight invalid fields
- **Gem Changes**
  - Updated to Rails 3.1.0.rc6

### Testing
- Add Navigation integration tests for friendly forwarding and redirection to login page

## 1.1.0 (August 5, 2011)

### Enhancements
- Replace Prototype with jQuery
- Replace WillPaginate with Kaminari
- Replace CalendarDateSelect with jQuery DatePicker
- Sort Entry Autocomplete by most commonly used
- **Gem Changes**
  - Updated to Rails 3.1.0.rc4
  - Updated to Devise 1.3.4

### Testing
- Fixtures updated
- Test base cleaned up

## 1.0.0 (June 19, 2011)

- Accounts can be created
- Charge types can be added to accounts
- Entries can be input from calendar view and associated with charge types
- Overall graph allows view of yearly and month by month spending
- Statistics for average expenditures, charged balance, and account balance displayed on dashboard
