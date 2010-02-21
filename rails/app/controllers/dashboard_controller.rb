class DashboardController < ApplicationController

  navigation :dashboard
  sidebar

  access_control do
    allow all
  end

  def index
  end

end
