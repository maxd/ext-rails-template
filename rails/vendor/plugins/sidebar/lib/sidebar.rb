# Adds a method to management the display of the sidebar. To specify that the sidebar should be applied to
# or excluded from given controller actions, use the :only and :except parameters.
#
# ==== Examples
#   class AccountController << ActionController::Base
#     sidebar # Show sidebar for all actions in controller
#     ...
#   end
#
#   class AccountSettingsController << ActionController::Base
#     sidebar :only => [ :index, :show ] # Show sidebar for index and show actions in controller 
#     ...
#   end
#
module Sidebar
  module ControllerMethods

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
        
        base.helper_method :has_sidebar?
      end
    end

    module ClassMethods

      def sidebar(*args)
        self.class_eval do
          define_method :__sidebar_filter do
            @show_sidebar = true
          end

          private :__sidebar_filter
          before_filter :__sidebar_filter, *args
        end
      end

    end

    module InstanceMethods

      def has_sidebar?
        path = "#{self.class.controller_path}/_sidebar"
        self.view_paths.find_template(path, "html") rescue return false
        @show_sidebar
      end

    end

  end
end