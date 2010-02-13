# Configures main navigation menu

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = "app-active-item"
  navigation.items do |primary|

    primary.item :new, t(".new"), new_admin_user_path

  end
end