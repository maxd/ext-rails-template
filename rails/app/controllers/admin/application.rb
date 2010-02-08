class Admin::Application < ApplicationController

  layout 'admin/application'

  TITLE = ApplicationController::TITLE

  access_control do
    default :deny

    allow :admin
  end

end
