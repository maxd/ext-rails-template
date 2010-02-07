# Configures main navigation menu

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = "app-active-item"
  navigation.items do |primary|

    primary.item :dashboard, t(".dashboard"), dashboard_path

  end
end