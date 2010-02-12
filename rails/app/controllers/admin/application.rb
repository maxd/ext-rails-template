class Admin::Application < ApplicationController

  layout 'admin/application'

  TITLE = ApplicationController::TITLE

  access_control do
    default :deny

    allow :admin
  end

private

  # Admin panel required SSL by default
  def ssl_required?
    true
  end

end
