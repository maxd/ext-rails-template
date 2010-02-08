# Configures main navigation menu

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = "app-active-item"
  navigation.items do |primary|

    primary.item :dashboard, t(".dashboard"), admin_dashboard_path
    primary.item :users, t(".users"), admin_users_path

  end
end