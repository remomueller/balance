## 2.0.0

### Enhancements
- **General Changes**
  - Started rewriting views using haml
  - Added a task to import data from CSVs
    - `bundle exec rake backup:import FOLDER=20160320173700`
  - Users can backup data from their account
- **Entry Changes**
  - Entry description fields now expand automatically to fit longer descriptions
  - Hovering mouse over entries now highlights the entry on the calendar
  - Moving entries on calendar no longer refreshes the entire page
- **Gem Changes**
  - Updated to Ruby 2.3.1
  - Updated to rails 4.2.6
  - Updated to pg 0.18.4
  - Updated to simplecov 0.11.2
  - Updated to jquery-rails 4.1.1

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
    - `bundle exec rake data:export`
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
