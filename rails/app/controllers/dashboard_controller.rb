class DashboardController < ApplicationController

  navigation :dashboard

  access_control do
    allow all
  end

  def index
  end

end
