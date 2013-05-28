# Use to configure basic appearance of template
Contour.setup do |config|

  # Enter your application name here. The name will be displayed in the title of all pages, ex: AppName - PageTitle
  config.application_name = DEFAULT_APP_NAME

  # If you want to style your name using html you can do so here, ex: <b>App</b>Name
  # config.application_name_html = ''

  # Enter your application version here. Do not include a trailing backslash. Recommend using a predefined constant
  config.application_version = Balance::VERSION::STRING

  # Enter your application header background image here.
  config.header_background_image = '' # 'backdrop_faded.png'

  # Enter your application header title image here.
  # config.header_title_image = ''

  # Enter the items you wish to see in the menu
  config.menu_items = [
    {
      name: 'Login', display: 'not_signed_in', path: 'new_user_session_path', position: 'right',
      links: [{ name: 'Sign Up', path: 'new_user_registration_path' },
              { divider: true },
              { authentications: true }]
    },
    {
      name: 'current_user.name', eval: true, display: 'signed_in', path: 'root_path', position: 'right',
      links: [{ html: '"<div class=\"small quiet\">"+current_user.email+"</div>"', eval: true },
              { name: 'Authentications', path: 'authentications_path', condition: 'not PROVIDERS.blank?' },
              { divider: true },
              { name: 'Logout', path: 'destroy_user_session_path' }]
    },
    {
      name: 'Calendar', display: 'always', path: 'root_path', position: 'left',
      links: [{ name: 'Current Balance', path: 'current_balance_entries_path' },
              { name: 'Averages', path: 'averages_entries_path' }]
    },
    {
      name: 'Graphs', display: 'signed_in', path: 'overview_entries_path', position: 'left'
    },
    {
      name: 'Accounts', display: 'signed_in', path: 'accounts_path', position: 'left',
      links: [{ name: 'Create', path: 'new_account_path' }]
    },
    {
      name: 'Charge Types', display: 'signed_in', path: 'charge_types_path', position: 'left',
      links: [{ name: 'Create', path: 'new_charge_type_path' }]
    },
    {
      name: 'Entries', display: 'signed_in', path: 'entries_path', position: 'left',
      links: [{ name: 'Create', path: 'new_entry_path' }]
    }
  ]

  # Enter an address of a valid RSS Feed if you would like to see news on the sign in page.
  # config.news_feed = ''

  # Enter the max number of items you want to see in the news feed.
  # config.news_feed_items = 5

  # An array of hashes that specify additional fields to add to the sign up form
  # An example might be [ { attribute: 'first_name', type: 'text_field' }, { attribute: 'last_name', type: 'text_field' } ]
  config.sign_up_fields = [ { attribute: 'first_name', type: 'text_field' }, { attribute: 'last_name', type: 'text_field' } ]

  # An array of text fields used to trick spam bots using the honeypot approach. These text fields will not be displayed to the user.
  # An example might be [ :url, :address, :contact, :comment ]
  config.spam_fields = [ :url, :address, :contact, :comment ]
end
