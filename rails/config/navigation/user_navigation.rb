# Configures user navigation menu

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = "app-active-item"
  navigation.items do |primary|

    primary.item :administration, t(".administration"), admin_dashboard_path, :if => lambda { current_user.present? and current_user.has_role?(:admin) }
    primary.item :register, t(".register"), register_path, :if => lambda { current_user.nil? and ENABLE_USER_REGISTRATION }
    primary.item :login, t(".login"), login_path,          :if => lambda { current_user.nil? }
    primary.item :profile, t(".profile"), profile_path,    :if => lambda { current_user.present? }
    primary.item :logout, t(".logout"), logout_path,       :if => lambda { current_user.present? }

  end
end