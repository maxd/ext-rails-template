# Configures dashboard sidebar menu

SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = "app-active-item"
  navigation.items do |primary|

    primary.item :action1, "Action1", "#"
    primary.item :action2, "Action2", "#"

  end
end