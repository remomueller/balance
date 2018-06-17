# frozen_string_literal: true

# Override for devise sessions controller.
class SessionsController < Devise::SessionsController
  layout "layouts/full_page"
end
