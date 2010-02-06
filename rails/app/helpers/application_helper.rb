# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def has_partial?(partial_path)
    path = "#{controller.class.controller_path}/_#{partial_path}"
    self.view_paths.find_template(path, "html") rescue return false
    true
  end

end
