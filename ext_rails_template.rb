# Remove unused files
run "rm public/index.html"

# Add used gems
gem "russian", :version => ">=0.2.5", :source => "http://gemcutter.org"
gem "haml", :source => "http://gemcutter.org"
gem "authlogic", :source => "http://gemcutter.org"
gem "acl9", :source => "http://gemcutter.org"
gem "validation_reflection", :source => "http://gemcutter.org"
gem "formtastic", :source => "http://gemcutter.org"

# Update database.yml file (add section for cucumber)
gsub_file "config/database.yml", /test:/mi do
  "test: &TEST"
end

File.open("config/database.yml", "a") do |f|
  f.write "\n"
  f.write "cucumber:\n"
  f.write "  <<: *TEST\n"
end

# Additional application files

file "app/views/notifier/password_reset_instructions.html.haml", %q{
%h1 Password Reset Instructions

%p
  A request to reset your password has been made. If you did not
  make this request, simply ignore this email. If you did make this
  request, follow the link below.

= link_to "Reset Password!", @reset_password_url

}

file "app/views/layouts/admin/_main_navigation.html.haml", %q{
.app-main-navigation.clearfix
  %ul
    %li{ :class => "active" }
      %a{ :href => "#" } General
    %li
      %a{ :href => "#"} Ideas
}

file "app/views/layouts/admin/application.html.haml", %q{
!!! XML
!!! Strict
%html
  %head
    %meta{ :"http-equiv" => "Content-Type", :content => "text/html; charset=utf-8" } 
    %title= Admin::Application::TITLE
    = javascript_include_tag :defaults
    = stylesheet_link_tag "reset", "clearfix", "formtastic", "formtastic_changes", "application"
    = yield :head
  %body
    .app-container
      .app-header
        %h1
          %a{ :href => "/" }= Admin::Application::TITLE
        = render :partial => 'layouts/admin/user_navigation'
        = render :partial => "layouts/admin/main_navigation"
      .app-wrapper.clearfix
        .app-main{ :class => ("app-has-sidebar" if has_partial? "sidebar" ) }
          - if flash.present?
            .app-flash
              - flash.each do |type, message|
                %div{ :class => "flash-message #{type}" }
                  %p= message
          = yield
        - if has_partial? "sidebar"
          .app-sidebar
            = render :partial => "sidebar"
    .app-footer
      %p
        = "Copyright &copy; 2010 #{Admin::Application::TITLE}"

}

file "app/views/layouts/admin/_user_navigation.html.haml", %q{
.app-user-navigation.clearfix
  %ul
    %li
      %a{ :href => "#" } Settings
    %li
      %a{ :href => "#"} Logout
}

file "app/views/layouts/_main_navigation.html.haml", %q{
.app-main-navigation.clearfix
  %ul
    %li{ :class => "active" }
      %a{ :href => "#" } General
    %li
      %a{ :href => "#"} Ideas
}

file "app/views/layouts/application.html.haml", %q{
!!! XML
!!! Strict
%html
  %head
    %meta{ :"http-equiv" => "Content-Type", :content => "text/html; charset=utf-8" } 
    %title= ApplicationController::TITLE
    = javascript_include_tag :defaults
    = stylesheet_link_tag "reset", "clearfix", "formtastic", "formtastic_changes", "application"
    = yield :head
    - if yield :style
      %style{ :type => "text/css" }
        = yield :style
  %body
    .app-container
      .app-header
        %h1
          %a{ :href => "/" }= ApplicationController::TITLE
        = render :partial => 'layouts/user_navigation'
        = render :partial => "layouts/main_navigation"
      .app-wrapper.clearfix
        .app-main{ :class => ("app-has-sidebar" if has_partial? "sidebar" ) }
          - if flash.present?
            .app-flash
              - flash.each do |type, message|
                %div{ :class => "flash-message #{type}" }
                  %p= message
          = yield
        - if has_partial? "sidebar"
          .app-sidebar
            = render :partial => "sidebar"
    .app-footer
      %p
        = "Copyright &copy; 2008 &ndash; #{Date.today.year} #{ApplicationController::TITLE}"                        

}

file "app/views/layouts/_user_navigation.html.haml", %q{
.app-user-navigation.clearfix
  %ul
    - if !current_user
      %li
        %a{ :href => register_path } Register
      %li
        %a{ :href => login_path } Login
    - else
      %li
        %a{ :href => profile_path } Profile
      %li
        %a{ :href => logout_path } Logout



}

file "app/views/dashboard/index.html.haml", %q{
%table.app-table
  %thead
    %tr
      %th Name
      %th Description
      %th Number
      %th Actions
  %tbody
    %tr
      %td
        %a{ :href => "#" } Name - 1
      %td Description - 1
      %td.number 1
      %td.buttons Actions - 1
    %tr
      %td
        %a{ :href => "#" } Name - 2
      %td Description - 2
      %td.number 2
      %td.buttons Actions - 2


}

file "app/views/dashboard/_sidebar.html.haml", %q{
.app-block
  %h3 Actions
  %ul.app-navigation
    %li
      %a{ :href => "#" } Create...
    %li
      %a{ :href => "#" } Edit...

.app-block
  %h3 Information
  .app-content
    %p New information text for sidebar context                
}

file "app/views/user_session/register.html.haml", %q{
- content_for :style do
  div.register-form { width: 500px; margin: 0 auto; }
  div.register-form h1 { font-size: 2em; margin-bottom: 1em; }
  form.formtastic fieldset ol li { display: block; margin-bottom: 1em; }
  form.formtastic .buttons li.cancel { padding-top: 4px; }

.register-form
  %h1= t(".title")

  - semantic_form_for @user, :url => register_path do |form|
    - form.inputs do
      = form.input :login, :input_html => { :autocomplete => "off" }
      = form.input :password, :input_html => { :autocomplete => "off" }
      = form.input :password_confirmation, :input_html => { :autocomplete => "off" }
      = form.input :email, :input_html => { :autocomplete => "off" }
    - form.buttons do
      = form.commit_button t(".register")
      %li.cancel
        %span
          or
          = link_to t("cancel"), :back

}

file "app/views/user_session/reset_password.html.haml", %q{
- content_for :style do
  div.login-form { width: 400px; margin: 0 auto; }
  div.login-form .header h1 { font-size: 2em; margin-bottom: 1em; }
  form.formtastic { }
  form.formtastic .inputs input { width: 73% !important; }
  form.formtastic fieldset ol li { display: block; margin-bottom: 1em; }
  form.formtastic fieldset { display: block; }
  form.formtastic .buttons li.cancel { padding-top: 4px; }

.login-form
  .header
    %h1= t(".title")

  - semantic_form_for @user, :url => reset_password_path(params[:id]) do |form|
    - form.inputs do
      = form.input :password, :as => :password
      = form.input :password_confirmation, :as => :password
    - form.buttons do
      = form.commit_button t(".reset")
      %li.cancel
        %span
          or
          = link_to t("cancel"), :back

}

file "app/views/user_session/edit_profile.html.haml", %q{
- content_for :style do
  div.profile-form { width: 500px; margin: 0 auto; }
  div.profile-form h1 { font-size: 2em; margin-bottom: 1em; }
  form.formtastic fieldset ol li { display: block; margin-bottom: 1em; }
  form.formtastic .buttons li.cancel { padding-top: 4px; }

.profile-form
  %h1= t(".title")

  - semantic_form_for @user, :url => edit_profile_path do |form|
    - form.inputs do
      = form.input :password, :input_html => { :autocomplete => "off" }
      = form.input :password_confirmation, :input_html => { :autocomplete => "off" }
      = form.input :email, :input_html => { :autocomplete => "off" }
    - form.buttons do
      = form.commit_button t(".change")
      %li.cancel
        %span
          or
          = link_to t("cancel"), :back

}

file "app/views/user_session/login.html.haml", %q{
- content_for :style do
  div.login-form { width: 400px; margin: 0 auto; }
  div.login-form .header { position: relative; }
  div.login-form .header h1 { font-size: 2em; margin-bottom: 1em; }
  div.login-form .header a { position: absolute; top: 0px; right: 10px; }
  form.formtastic { }
  form.formtastic .inputs input { width: 73% !important; }
  form.formtastic fieldset ol li { display: block; margin-bottom: 1em; }
  form.formtastic fieldset { display: block; }
  form.formtastic .buttons li.cancel { padding-top: 4px; }

.login-form
  .header
    %h1= t(".title")
    = link_to t(".reset_password"), request_reset_password_path

  - semantic_form_for @user_session, :url => login_path do |form|
    - form.inputs do
      = form.input :login
      = form.input :password, :as => :password
      = form.input :remember_me, :as => :boolean, :required => false
    - form.buttons do
      = form.commit_button t(".login")
      %li.cancel
        %span
          or
          = link_to t("cancel"), :back
      

}

file "app/views/user_session/profile.html.haml", %q{
- content_for :style do
  h1 { font-size: 2em; margin-bottom: 1em; }
  table { width: 600px; margin: 0 auto; padding: 0 5px; }

%h1 User Profile

%table
  %tbody
    %tr
      %td Login
      %td= @user.login
    %tr
      %td Email
      %td= @user.email
    %tr
      %td Login count
      %td= @user.login_count
    %tr
      %td Last login at
      %td= l(@user.last_login_at.localtime, :format => :short)
    %tr
      %td Current login at
      %td= l(@user.current_login_at.localtime, :format => :short)
    %tr
      %td Last login ip
      %td= @user.last_login_ip
    %tr
      %td Current login ip
      %td= @user.current_login_ip
  %tfoot
    %tr
      %td &nbsp;
      %td= link_to 'Edit', edit_profile_path
}

file "app/views/user_session/request_reset_password.html.haml", %q{
- content_for :style do
  div.request-reset-password-form { width: 400px; margin: 0 auto; }
  div.request-reset-password-form h1 { font-size: 2em; margin-bottom: 1em; }
  div.request-reset-password-form p { margin: 7px 0; }
  form.formtastic fieldset ol li { display: block; margin-bottom: 1em; }

.request-reset-password-form
  %h1 Reset Password
  %p Fill out the form below and instructions to reset your password will be emailed to you:

  - semantic_form_for :request_reset_password do |form|
    = form.inputs :email
    - form.buttons do
      = form.commit_button t(".send_request")
      %li.cancel
        %span
          or
          = link_to t("cancel"), :back
}

file "app/controllers/user_session_controller.rb", %q{
class UserSessionController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [ :reset_password ]

  access_control do
    default :deny

    allow logged_in, :except => [ :login, :register, :request_reset_password ]
    allow anonymous, :except => [ :logout, :profile, :edit_profile ] 
  end

  def login
    @user_session = UserSession.new(params[:user_session])
    if request.post? and @user_session.save
      flash[:notice] = t("user_session.login.success_login")
      redirect_back_or_default root_url
    end
  end

  def logout
    current_user_session.destroy
    flash[:notice] = t("user_session.logout.success_logout")
    redirect_back_or_default root_url
  end

  def register
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash[:notice] = t("user_session.register.account_registred")
      redirect_back_or_default root_url
    end
  end

  def profile
    @user = @current_user
  end

  def edit_profile
    @user = @current_user
    if request.put? and @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_back_or_default root_url
    end
  end

  def request_reset_password
    if request.post?
      @user = User.find_by_email(params[:request_reset_password][:email])
      if @user
        @user.deliver_password_reset_instructions!
        flash[:notice] = t("user_session.request_reset_password.email_notification")
        redirect_back_or_default root_url  
      else
        flash[:notice] = t("user_session.request_reset_password.nonexistent_email")
      end
    end
  end

  def reset_password
    if request.put?
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        flash[:notice] = t("user_session.reset_password.password_updated")
        redirect_to root_url
      end       
    end
  end

private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = t("user_session.load_user_using_perishable_token.wrong_perishable_token")
      redirect_back_or_default root_url
    end
  end

end

}

file "app/controllers/admin/application.rb", %q{
class Admin::Application < ApplicationController

  layout 'admin/application'

  TITLE = "Application Title {Admin Panel}"

end

}

file "app/controllers/application_controller.rb", %q{
class ApplicationController < ActionController::Base

  TITLE = "Application Title"

  rescue_from Acl9::AccessDenied, :with => :access_denied
  
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def access_denied
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
    else
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
    end
  end


  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end

}

file "app/controllers/dashboard_controller.rb", %q{
class DashboardController < ApplicationController

  access_control do
    allow all
  end

  def index
  end

end

}

file "app/models/role.rb", %q{
class Role < ActiveRecord::Base
  acts_as_authorization_role
end

}

file "app/models/user_session.rb", %q{
class UserSession < Authlogic::Session::Base
end
}

file "app/models/notifier.rb", %q{
class Notifier < ActionMailer::Base

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "noreplay@domain.com"
    recipients    user.email
    sent_on       Time.now
    body          :reset_password_url => reset_password_url(user.perishable_token)
  end

end

}

file "app/models/user.rb", %q{
class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)  
  end
  
end

}

file "app/helpers/user_session_helper.rb", %q{
module UserSessionHelper
end

}

file "app/helpers/dashboard_helper.rb", %q{
module DashboardHelper
end

}

file "app/helpers/application_helper.rb", %q{
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def has_partial?(partial_path)
    path = "#{controller.class.controller_path}/_#{partial_path}"
    self.view_paths.find_template(path, "html") rescue return false
    true
  end

end

}




file "config/environments/cucumber.rb", %q{
# Edit at your own peril - it's recommended to regenerate this file
# in the future when you upgrade to a newer version of Cucumber.

# IMPORTANT: Setting config.cache_classes to false is known to
# break Cucumber's use_transactional_fixtures method.
# For more information see https://rspec.lighthouseapp.com/projects/16211/tickets/165
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

config.gem 'cucumber-rails',   :lib => false, :version => '>=0.2.3' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber-rails'))
config.gem 'database_cleaner', :lib => false, :version => '>=0.2.3' unless File.directory?(File.join(Rails.root, 'vendor/plugins/database_cleaner'))
config.gem 'webrat',           :lib => false, :version => '>=0.6.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/webrat'))
config.gem 'rspec',            :lib => false, :version => '>=1.2.9' unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec'))
config.gem 'rspec-rails',      :lib => false, :version => '>=1.2.9' unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec-rails'))

config.gem 'spork',            :lib => false, :version => '>=0.7.4' unless File.directory?(File.join(Rails.root, 'vendor/plugins/spork'))

config.gem 'email_spec',       :lib => false, :version => '>=0.4.0'  unless File.directory?(File.join(Rails.root, 'vendor/plugins/email_spec'))

config.action_mailer.default_url_options = { :host => "localhost:3000" }

}


file "config/initializers/formtastic.rb", %q{
# Set the default text field size when input is a string. Default is 50.
# Formtastic::SemanticFormBuilder.default_text_field_size = 50

# Should all fields be considered "required" by default?
# Defaults to true, see ValidationReflection notes below.
# Formtastic::SemanticFormBuilder.all_fields_required_by_default = true

# Should select fields have a blank option/prompt by default?
# Defaults to true.
# Formtastic::SemanticFormBuilder.include_blank_for_select_by_default = true

# Set the string that will be appended to the labels/fieldsets which are required
# It accepts string or procs and the default is a localized version of
# '<abbr title="required">*</abbr>'. In other words, if you configure formtastic.required
# in your locale, it will replace the abbr title properly. But if you don't want to use
# abbr tag, you can simply give a string as below
# Formtastic::SemanticFormBuilder.required_string = "(required)"

# Set the string that will be appended to the labels/fieldsets which are optional
# Defaults to an empty string ("") and also accepts procs (see required_string above)
# Formtastic::SemanticFormBuilder.optional_string = "(optional)"

# Set the way inline errors will be displayed.
# Defaults to :sentence, valid options are :sentence, :list and :none
# Formtastic::SemanticFormBuilder.inline_errors = :sentence

# Set the method to call on label text to transform or format it for human-friendly
# reading when formtastic is user without object. Defaults to :humanize.
# Formtastic::SemanticFormBuilder.label_str_method = :humanize

# Set the array of methods to try calling on parent objects in :select and :radio inputs
# for the text inside each @<option>@ tag or alongside each radio @<input>@. The first method
# that is found on the object will be used.
# Defaults to ["to_label", "display_name", "full_name", "name", "title", "username", "login", "value", "to_s"]
# Formtastic::SemanticFormBuilder.collection_label_methods = [
#   "to_label", "display_name", "full_name", "name", "title", "username", "login", "value", "to_s"]

# Formtastic by default renders inside li tags the input, hints and then
# errors messages. Sometimes you want the hints to be rendered first than
# the input, in the following order: hints, input and errors. You can
# customize it doing just as below:
# Formtastic::SemanticFormBuilder.inline_order = [:input, :hints, :errors]

# Specifies if labels/hints for input fields automatically be looked up using I18n.
# Default value: false. Overridden for specific fields by setting value to true,
# i.e. :label => true, or :hint => true (or opposite depending on initialized value)
Formtastic::SemanticFormBuilder.i18n_lookups_by_default = true

# You can add custom inputs or override parts of Formtastic by subclassing SemanticFormBuilder and
# specifying that class here.  Defaults to SemanticFormBuilder.
# Formtastic::SemanticFormHelper.builder = MyCustomBuilder

}


file "config/initializers/i18n.rb", %q{
# Set default locale to :en (gem russian switch this settings to :ru)

I18n.default_locale = :en
}


file "config/locales/en.yml", %q{
en:
  cancel: "Cancel"

  user_session:
    login:
      title: "Login"
      login: "Login"
      reset_password: "Reset password"

      success_login: "Login successful!"

    logout:
      success_logout: "Logout successful!"

    register:
      title: "Register"
      register: "Register"

      account_registred: "Account registered!"

    request_reset_password:
      send_request: "Send request"

      email_notification: "Instructions to reset your password have been emailed to you. Please check your email."
      nonexistent_email: "No user was found with that email address"

    reset_password:
      title: "Change password"
      reset: "Reset Password"

      password_updated: "Password successfully updated"

    load_user_using_perishable_token:
      wrong_perishable_token: "We're sorry, but we could not locate your account. If you are having issues try
                               copying and pasting the URL from your email into your browser or restarting the
                               reset password process."

    edit_profile:
      title: "Change Profile"
      change: "Change"


}


file "config/cucumber.yml", %q{
<%
rerun = File.file?('rerun.txt') ? IO.read('rerun.txt') : ""
rerun_opts = rerun.to_s.strip.empty? ? "--format progress features" : "--format #{ENV['CUCUMBER_FORMAT'] || 'pretty'} #{rerun}"
std_opts = "#{rerun_opts} --format rerun --out rerun.txt --strict --tags ~@wip"
%>
default: --drb <%= std_opts %>
wip: --drb --tags @wip:3 --wip features

}


file "config/routes.rb", %q{
ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "dashboard"
  map.dashboard "", :controller => "dashboard", :action => "index" 
  map.login "/login", :controller => "user_session", :action => "login"
  map.logout "/logout", :controller => "user_session", :action => "logout" 

  map.register "/register", :controller => "user_session", :action => "register" 
  map.profile "/profile", :controller => "user_session", :action => "profile"
  map.edit_profile "/profile/edit", :controller => "user_session", :action => "edit_profile"

  map.request_reset_password "/reset_password/request", :controller => "user_session", :action => "request_reset_password"
  map.reset_password "/reset_password/:id", :controller => "user_session", :action => "reset_password"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

}




file "db/migrate/20100127202616_create_roles.rb", %q{
class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name,               :limit => 40
      t.string :authorizable_type,  :limit => 40
      t.integer :authorizable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end

}

file "db/migrate/20100114222613_create_sessions.rb", %q{
class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end

  def self.down
    drop_table :sessions
  end
end

}

file "db/migrate/20100114222739_create_users.rb", %q{
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      
      t.timestamps
    end

    User.create! :login => "admin", :email => "admin@example.com", :password => "admin", :password_confirmation => "admin"
  end

  def self.down
    drop_table :users
  end
end

}

file "db/migrate/20100127202741_create_roles_users.rb", %q{
class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table "roles_users", :id => false, :force => true do |t|
      t.references  :user
      t.references  :role
      t.timestamps
    end
  end

  def self.down
    drop_table "roles_users"
  end
end

}


file "db/seeds.rb", %q{
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

}



file "features/reset_password.feature", %q{
Feature: Reset password
  In order to restore forgotten password
  A registered user
  Should reset password

  Scenario: User select incorrect e-mail
    Given I am a not logined to application
    When I go to the request reset password page
    And fill in "Email" with "unknown@example.com"
    And press "Send request"
    Then I should see flash with "No user was found with that email address"

  Scenario: User select correct email and reset password
    Given I am request reset password for "admin@example.com" email
    And open reset password page from "admin@example.com" email
    When I fill in "Password" with "newpass"
    And fill in "Password confirmation" with "newpass"
    And press "Reset Password"
    Then I should see flash with "Password successfully updated"
    And should be logined to application
    And I should be able to log in with login "admin" and password "newpass"

  Scenario: User select correct email and enter incorrect reset password
    Given I am request reset password for "admin@example.com" email
    And open reset password page from "admin@example.com" email
    When I fill in "Password" with "newpass"
    And fill in "Password confirmation" with "newpass2"
    And press "Reset Password"
    Then I should see form validation for "Password"
    Then should not be logined to application
    And I should be able to log in with login "admin" and password "admin"

  Scenario: User open reset password with nonexistent perishable token
    When I go to the reset password page with Id "unknown"
    Then I should see flash with "we could not locate your account"
    And should not be logined to application


}

file "features/registration.feature", %q{
Feature: Registration in application
  In order to work with advanced features of application
  As anonymous user
  I want to register in application


  Scenario: Not logined user should see register link on dashboard page
    Given I am a not logined to application
    When I go to the dashboard page
    Then I should see "/register" link


  Scenario: Success registration in application
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 | user             |
      | Password              | password         |
      | Password Confirmation | password         |
      | Email                 | user@example.com |
    And press "Register"
    Then I should be registered in application


  Scenario: Fail registration in application with empty fields
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 |                  |
      | Password              |                  |
      | Password Confirmation |                  |
      | Email                 |                  |
    And press "Register"
    Then I should see form validation for "Login" field
    And should see form validation for "Password" field
    And should see form validation for "Password confirmation" field
    And should see form validation for "Email" field
    And should not be registered in application


  Scenario: Fail registration in application with empty login
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 |                  |
      | Password              | password         |
      | Password Confirmation | password         |
      | Email                 | user@example.com |
    And press "Register"
    Then I should see form validation for "Login" field
    And should not be registered in application


  Scenario: Fail registration in application with empty password
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 | user             |
      | Password              |                  |
      | Password Confirmation | password         |
      | Email                 | user@example.com |
    And press "Register"
    Then I should see form validation for "Password" field
    And should not be registered in application


  Scenario: Fail registration in application with different password and confirmation password
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 | user             |
      | Password              | password         |
      | Password Confirmation | password2        |
      | Email                 | user@example.com |
    And press "Register"
    Then I should see form validation for "Password" field
    And should not be registered in application


  Scenario: Fail registration in application with empty e-mail
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 | user             |
      | Password              | password         |
      | Password Confirmation | password         |
      | Email                 |                  |
    And press "Register"
    Then I should see form validation for "Email" field 
    And should not be registered in application


  Scenario: Fail registration in application with login which already registered
    Given I am a not logined to application
    When I go to the registration page
    And I fill in the following:
      | Login                 | admin             |
      | Password              | pass              |
      | Password Confirmation | pass              |
      | Email                 | admin@example.com |
    And press "Register"
    Then I should see form validation for "Login" field
    And should not be registered in application


  Scenario: I can press Cancel link and return to previous page
    Given I am a not logined to application
    When I go to the registration page
    And follow "Cancel"
    Then I should be on the dashboard page

    
}

file "features/support/paths.rb", %q{
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      dashboard_path
    when /the dashboard page/
      dashboard_path
    when /the login page/
      login_path
    when /the logout page/
      logout_path
    when /the registration page/
      register_path
    when /the request reset password page/
      request_reset_password_path
    when /the reset password page with Id "([^\"]*)"/
      reset_password_path($1)
    when /the profile page/
      profile_path
    when /the edit profile page/
      edit_profile_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

}

file "features/support/env.rb", %q{
# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'rubygems'
require 'spork'
 
Spork.prefork do
  ENV["RAILS_ENV"] ||= "cucumber"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
  
  require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
  require 'cucumber/rails/rspec'
  require 'cucumber/rails/world'
  require 'cucumber/rails/active_record'
  require 'cucumber/web/tableish'


  require 'webrat'
  require 'webrat/core/matchers'
#  require 'cucumber/webrat/element_locator' # Deprecated in favor of #tableish - remove this line if you don't use #element_at or #table_at
  require 'webrat/integrations/rspec-rails'

  Webrat.configure do |config|
    config.mode = :rails
    config.open_error_files = false # Set to true if you want error pages to pop up in the browser
  end
  
  require "email_spec"
  require 'email_spec/cucumber'

end
 
Spork.each_run do
  # If you set this to false, any error raised from within your app will bubble 
  # up to your step definition and out to cucumber unless you catch it somewhere
  # on the way. You can make Rails rescue errors and render error pages on a
  # per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
  #
  # If you set this to true, Rails will rescue all errors and render error
  # pages, more or less in the same way your application would behave in the
  # default production environment. It's not recommended to do this for all
  # of your scenarios, as this makes it hard to discover errors in your application.
  ActionController::Base.allow_rescue = false
  
  # If you set this to true, each scenario will run in a database transaction.
  # You can still turn off transactions on a per-scenario basis, simply tagging 
  # a feature or scenario with the @no-txn tag. If you are using Capybara,
  # tagging with @culerity or @javascript will also turn transactions off.
  #
  # If you set this to false, transactions will be off for all scenarios,
  # regardless of whether you use @no-txn or not.
  #
  # Beware that turning transactions off will leave data in your database 
  # after each scenario, which can lead to hard-to-debug failures in 
  # subsequent scenarios. If you do this, we recommend you create a Before
  # block that will explicitly put your database in a known state.
  Cucumber::Rails::World.use_transactional_fixtures = true
  
  # How to clean your database when transactions are turned off. See
  # http://github.com/bmabey/database_cleaner for more info.
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation

end

}

file "features/authorization.feature", %q{
Feature: Anonymous user shouldn't have access for some application resources
  In order to restrict access for some application resources
  A anonymous user
  Shouldn't have access for some application resources

  Scenario: Anonymous user should have access to dashboard page
    Given I am a not logined to application
    When I go to the dashboard page
    Then I should be on the dashboard page

  Scenario: Anonymous user should have access to login page
    Given I am a not logined to application
    When I go to the login page
    Then I should be on the login page

  Scenario: Anonymous user should have access to register page
    Given I am a not logined to application
    When I go to the registration page
    Then I should be on the registration page

  Scenario: Anonymous user should have access to request reset password page
    Given I am a not logined to application
    When I go to the request reset password page
    Then I should be on the request reset password page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to logout page
    Given I am a not logined to application
    When I go to the logout page
    Then I should be on the login page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to profile page
    Given I am a not logined to application
    When I go to the profile page
    Then I should be on the login page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to edit profile page
    Given I am a not logined to application
    When I go to the edit profile page
    Then I should be on the login page

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to login page
    Given I am logined to application
    When I go to the login page
    Then I should be on the dashboard page
    And should see flash with "You must be logged out to access this page"

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to register page
    Given I am logined to application
    When I go to the registration page
    Then I should be on the dashboard page
    And should see flash with "You must be logged out to access this page"

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to request reset password page
    Given I am logined to application
    When I go to the request reset password page
    Then I should be on the dashboard page
    And should see flash with "You must be logged out to access this page"

}

file "features/authentication.feature", %q{
Feature: Authentication to application
  In order to work with application
  As registered user
  I want to login in application

  Scenario: Not logined user should see login link on dashboard page
    Given I am a not logined to application
    When I go to the dashboard page
    Then I should see "/login" link

  Scenario: Success login to application
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | admin            |
    And press "Login"
    Then I should see flash with "Login successful!"
    And should be logined to application
    And should see "/profile" link
    And "/logout" link

  Scenario: Fail login to application with invalid login
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | adminko          |
      | Password              | admin            |
    And press "Login"
    Then I should see form validation for "Login" field
    And should not be logined to application
    And should see "/login" link

  Scenario: Fail login to application with invalid password
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | adminko          |
    And press "Login"
    Then I should see form validation for "Password" field
    And should not be logined to application
    And should see "/login" link

}

file "features/dashboard.feature", %q{
Feature: Show dashboard page
  In order to show home/root page
  A any user
  Should be able to see dashboard page

  Scenario: Show dashboard page for anonymous user
    Given I am anonymous user
    When I go to the dashboard page
    Then I should see dashboard page

  Scenario: Show dashboard page for sign up user
    Given I am sing up user
    When I go to the dashboard page
    Then I should see dashboard page
}

file "features/step_definitions/email_steps.rb", %q{
# Commonly used email steps
#
# To add your own steps make a custom_email_steps.rb
# The provided methods are:
#
# last_email_address
# reset_mailer
# open_last_email
# visit_in_email
# unread_emails_for
# mailbox_for
# current_email
# open_email
# read_emails_for
# find_email
#
# General form for email scenarios are:
#   - clear the email queue (done automatically by email_spec)
#   - execute steps that sends an email
#   - check the user received an/no/[0-9] emails
#   - open the email
#   - inspect the email contents
#   - interact with the email (e.g. click links)
#
# The Cucumber steps below are setup in this order.

module EmailHelpers
  def current_email_address
    # Replace with your a way to find your current email. e.g @current_user.email
    # last_email_address will return the last email address used by email spec to find an email.
    # Note that last_email_address will be reset after each Scenario.
    last_email_address || "example@example.com"
  end
end

World(EmailHelpers)

#
# Reset the e-mail queue within a scenario.
# This is done automatically before each scenario.
#

Given /^(?:a clear email queue|no emails have been sent)$/ do
  reset_mailer
end

#
# Check how many emails have been sent/received
#

Then /^(?:I|they|"([^"]*?)") should receive (an|no|\d+) emails?$/ do |address, amount|
  unread_emails_for(address).size.should == parse_email_count(amount)
end

Then /^(?:I|they|"([^"]*?)") should have (an|no|\d+) emails?$/ do |address, amount|
  mailbox_for(address).size.should == parse_email_count(amount)
end

# DEPRECATED
# The following methods are left in for backwards compatibility and
# should be removed by version 0.4.0
Then /^(?:I|they|"([^"]*?)") should not receive an email$/ do |address|
  email_spec_deprecate "The step 'I/they/[email] should not receive an email' is no longer supported.
                      Please use 'I/they/[email] should receive no emails' instead."
  unread_emails_for(address).size.should == 0
end

#
# Accessing emails
#

# Opens the most recently received email
When /^(?:I|they|"([^"]*?)") opens? the email$/ do |address|
  open_email(address)
end

When /^(?:I|they|"([^"]*?)") opens? the email with subject "([^"]*?)"$/ do |address, subject|
  open_email(address, :with_subject => subject)
end

When /^(?:I|they|"([^"]*?)") opens? the email with text "([^"]*?)"$/ do |address, text|
  open_email(address, :with_text => text)
end

#
# Inspect the Email Contents
#

Then /^(?:I|they) should see "([^"]*?)" in the email subject$/ do |text|
  current_email.should have_subject(text)
end

Then /^(?:I|they) should see \/([^"]*?)\/ in the email subject$/ do |text|
  current_email.should have_subject(Regexp.new(text))
end

Then /^(?:I|they) should see "([^"]*?)" in the email body$/ do |text|
  current_email.body.should include(text)
end

Then /^(?:I|they) should see \/([^"]*?)\/ in the email body$/ do |text|
  current_email.body.should =~ Regexp.new(text)
end

Then /^(?:I|they) should see the email delivered from "([^"]*?)"$/ do |text|
  current_email.should be_delivered_from(text)
end

Then /^(?:I|they) should see "([^\"]*)" in the email "([^"]*?)" header$/ do |text, name|
  current_email.should have_header(name, text)
end

Then /^(?:I|they) should see \/([^\"]*)\/ in the email "([^"]*?)" header$/ do |text, name|
  current_email.should have_header(name, Regexp.new(text))
end


# DEPRECATED
# The following methods are left in for backwards compatibility and
# should be removed by version 0.4.0.
Then /^(?:I|they) should see "([^"]*?)" in the subject$/ do |text|
  email_spec_deprecate "The step 'I/they should see [text] in the subject' is no longer supported.
                      Please use 'I/they should see [text] in the email subject' instead."
  current_email.should have_subject(Regexp.new(text))
end
Then /^(?:I|they) should see "([^"]*?)" in the email$/ do |text|
  email_spec_deprecate "The step 'I/they should see [text] in the email' is no longer supported.
                      Please use 'I/they should see [text] in the email body' instead."
  current_email.body.should =~ Regexp.new(text)
end

#
# Interact with Email Contents
#

When /^(?:I|they) follow "([^"]*?)" in the email$/ do |link|
  visit_in_email(link)
end

When /^(?:I|they) click the first link in the email$/ do
  click_first_link_in_email
end


}

file "features/step_definitions/common_steps.rb", %q{
Then /^(?:|I )should see "([^\"]*)" link$/ do |link|
  response.should have_xpath("//a[@href='#{link}']")
end

Then /^"([^\"]*)" link$/ do |link|
  response.should have_xpath("//a[@href='#{link}']")
end

Then /^(?:|I )should see form validation for "([^\"]*)"(?:| field)$/ do |field|
  response.should have_xpath("//p[@class='inline-errors']/parent::node()/label[contains(.,'#{field}')]")  
end

Then /^(?:|I )should see flash with "([^\"]*)"$/ do |text|
  response.should have_xpath("//div[starts-with(@class, 'flash-message')]/p[contains(.,'#{text}')]")  
end

Then /^I should be able to log in with login "([^\"]*)" and password "([^\"]*)"$/ do |login, password|
  UserSession.new(:login => login, :password => password).save.should == true
end

}

file "features/step_definitions/web_steps.rb", %q{
# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

# Commonly used webrat steps
# http://github.com/brynary/webrat

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^\"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )follow "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, link)
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

# Use this step in conjunction with Rail's datetime_select helper. For example:
# When I select "December 25, 2008 10:00" as the date and time
When /^(?:|I )select "([^\"]*)" as the date and time$/ do |time|
  select_datetime(time)
end

# Use this step when using multiple datetime_select helpers on a page or
# you want to specify which datetime to select. Given the following view:
#   <%= f.label :preferred %><br />
#   <%= f.datetime_select :preferred %>
#   <%= f.label :alternative %><br />
#   <%= f.datetime_select :alternative %>
# The following steps would fill out the form:
# When I select "November 23, 2004 11:20" as the "Preferred" date and time
# And I select "November 25, 2004 10:30" as the "Alternative" date and time
When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, datetime_label|
  select_datetime(datetime, :from => datetime_label)
end

# Use this step in conjunction with Rail's time_select helper. For example:
# When I select "2:20PM" as the time
# Note: Rail's default time helper provides 24-hour time-- not 12 hour time. Webrat
# will convert the 2:20PM to 14:20 and then select it.
When /^(?:|I )select "([^\"]*)" as the time$/ do |time|
  select_time(time)
end

# Use this step when using multiple time_select helpers on a page or you want to
# specify the name of the time on the form.  For example:
# When I select "7:30AM" as the "Gym" time
When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" time$/ do |time, time_label|
  select_time(time, :from => time_label)
end

# Use this step in conjunction with Rail's date_select helper.  For example:
# When I select "February 20, 1981" as the date
When /^(?:|I )select "([^\"]*)" as the date$/ do |date|
  select_date(date)
end

# Use this step when using multiple date_select helpers on one page or
# you want to specify the name of the date on the form. For example:
# When I select "April 26, 1982" as the "Date of Birth" date
When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date$/ do |date, date_label|
  select_date(date, :from => date_label)
end

When /^(?:|I )check "([^\"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^\"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^\"]*)"$/ do |field|
  choose(field)
end

# Adds support for validates_attachment_content_type. Without the mime-type getting
# passed to attach_file() you will get a "Photo file is not one of the allowed file types."
# error message 
When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"$/ do |path, field|
  type = path.split(".")[1]

  case type
  when "jpg"
    type = "image/jpg" 
  when "jpeg"
    type = "image/jpeg" 
  when "png"
    type = "image/png" 
  when "gif"
    type = "image/gif"
  end
  
  attach_file(field, path, type)
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  if defined?(Spec::Rails::Matchers)
    response.should contain(text)
  else
    assert_contain text
  end
end

Then /^(?:|I )should see "([^\"]*)" within "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    if defined?(Spec::Rails::Matchers)
      content.should contain(text)
    else
      assert content.include?(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if defined?(Spec::Rails::Matchers)
    response.should contain(regexp)
  else
    assert_contain regexp
  end
end

Then /^(?:|I )should see \/([^\/]*)\/ within "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    if defined?(Spec::Rails::Matchers)
      content.should contain(regexp)
    else
      assert content =~ regexp
    end
  end
end

Then /^(?:|I )should not see "([^\"]*)"$/ do |text|
  if defined?(Spec::Rails::Matchers)
    response.should_not contain(text)
  else
    assert_not_contain text
  end
end

Then /^(?:|I )should not see "([^\"]*)" within "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    if defined?(Spec::Rails::Matchers)
        content.should_not contain(text)
    else
        assert !content.include?(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if defined?(Spec::Rails::Matchers)
    response.should_not contain(regexp)
  else
    assert_not_contain regexp
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/ within "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    if defined?(Spec::Rails::Matchers)
      content.should_not contain(regexp)
    else
      assert content !~ regexp
    end
  end
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  if defined?(Spec::Rails::Matchers)
    field_labeled(field).value.should =~ /#{value}/
  else
    assert_match(/#{value}/, field_labeled(field).value)
  end
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, value|
  if defined?(Spec::Rails::Matchers)
    field_labeled(field).value.should_not =~ /#{value}/
  else
    assert_no_match(/#{value}/, field_labeled(field).value)
  end
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label|
  if defined?(Spec::Rails::Matchers)
    field_labeled(label).should be_checked
  else
    assert field_labeled(label).checked?
  end
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  if defined?(Spec::Rails::Matchers)
    field_labeled(label).should_not be_checked
  else
    assert !field_labeled(label).checked?
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
  if defined?(Spec::Rails::Matchers)
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
}

file "features/step_definitions/reset_password_steps.rb", %q{
Then /^I should be with user.perishable_token on the reset password page$/ do
  user = User.first(:conditions => { :email => "admin@example.com" })

  Then "I should be on the reset password page with Id \"#{user.perishable_token}\""
end

Given /I am request reset password for "([^\"]*)" email/ do |email|
  steps %Q{
    Given I am a not logined to application
    When I go to the request reset password page
    And fill in "Email" with "#{email}"
    And press "Send request"
    Then I should see flash with "Instructions to reset your password have been emailed to you."
  }
end

Given /open reset password page from "([^\"]*)" email/ do |email|
  steps %Q{
    Given "#{email}" should receive an email
    When I open the email
    Then I should see "Reset Password!" in the email body
    When I follow "Reset Password!" in the email
    Then I should be with user.perishable_token on the reset password page
  }
end
}

file "features/step_definitions/authentication_steps.rb", %q{
Given /^I am a not logined to application$/ do
  visit dashboard_path
  controller.current_user.should be_nil
end

Given /^I am logined to application$/ do
  steps %Q{
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | admin            |
    And press "Login"
    Then I should see flash with "Login successful!"
  }
end

Then /^(?:|I )should be logined to application$/ do
  controller.current_user.should_not be_nil
end

Then /^(?:|I )should not be logined to application$/ do
  controller.current_user.should be_nil
end


}

file "features/step_definitions/registration_steps.rb", %q{
Then /^I should be registered in application$/ do
  controller.current_user.should_not be_nil
  controller.current_user.login.should == "user"
  controller.current_user.email.should == "user@example.com"
end

Then /^(?:|I )should not be registered in application$/ do
  controller.current_user.should be_nil
end

}

file "features/step_definitions/dashboard_steps.rb", %q{
Given /^I am anonymous user$/ do
  @current_user = nil
end

Then /^I should see dashboard page$/ do
  response.should have_selector("div.app-container")
end

Given /^I am sing up user$/ do
  @current_user = User.first
end
}



file "lib/tasks/cucumber.rake", %q{
# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

vendored_cucumber_bin = Dir["#{RAILS_ROOT}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new({:ok => 'db:test:prepare'}, 'Run features that should pass') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    Cucumber::Rake::Task.new({:wip => 'db:test:prepare'}, 'Run features that are being worked on') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'wip'
    end

    desc 'Run all features'
    task :all => [:ok, :wip]
  end
  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :default => :cucumber

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

end

}

file "lib/tasks/rspec.rake", %q{
gem 'test-unit', '1.2.3' if RUBY_VERSION.to_f >= 1.9
rspec_gem_dir = nil
Dir["#{RAILS_ROOT}/vendor/gems/*"].each do |subdir|
  rspec_gem_dir = subdir if subdir.gsub("#{RAILS_ROOT}/vendor/gems/","") =~ /^(\w+-)?rspec-(\d+)/ && File.exist?("#{subdir}/lib/spec/rake/spectask.rb")
end
rspec_plugin_dir = File.expand_path(File.dirname(__FILE__) + '/../../vendor/plugins/rspec')

if rspec_gem_dir && (test ?d, rspec_plugin_dir)
  raise "\n#{'*'*50}\nYou have rspec installed in both vendor/gems and vendor/plugins\nPlease pick one and dispose of the other.\n#{'*'*50}\n\n"
end

if rspec_gem_dir
  $LOAD_PATH.unshift("#{rspec_gem_dir}/lib")
elsif File.exist?(rspec_plugin_dir)
  $LOAD_PATH.unshift("#{rspec_plugin_dir}/lib")
end

# Don't load rspec if running "rake gems:*"
unless ARGV.any? {|a| a =~ /^gems/}

begin
  require 'spec/rake/spectask'
rescue MissingSourceFile
  module Spec
    module Rake
      class SpecTask
        def initialize(name)
          task name do
            # if rspec-rails is a configured gem, this will output helpful material and exit ...
            require File.expand_path(File.join(File.dirname(__FILE__),"..","..","config","environment"))

            # ... otherwise, do this:
            raise <<-MSG

#{"*" * 80}
*  You are trying to run an rspec rake task defined in
*  #{__FILE__},
*  but rspec can not be found in vendor/gems, vendor/plugins or system gems.
#{"*" * 80}
MSG
          end
        end
      end
    end
  end
end

Rake.application.instance_variable_get('@tasks').delete('default')

spec_prereq = File.exist?(File.join(RAILS_ROOT, 'config', 'database.yml')) ? "db:test:prepare" : :noop
task :noop do
end

task :default => :spec
task :stats => "spec:statsetup"

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new(:spec => spec_prereq) do |t|
  t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  desc "Run all specs in spec directory with RCov (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = lambda do
      IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
    end
  end

  desc "Print Specdoc for all specs (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:doc) do |t|
    t.spec_opts = ["--format", "specdoc", "--dry-run"]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

  desc "Print Specdoc for all plugin examples"
  Spec::Rake::SpecTask.new(:plugin_doc) do |t|
    t.spec_opts = ["--format", "specdoc", "--dry-run"]
    t.spec_files = FileList['vendor/plugins/**/spec/**/*_spec.rb'].exclude('vendor/plugins/rspec/*')
  end

  [:models, :controllers, :views, :helpers, :lib, :integration].each do |sub|
    desc "Run the code examples in spec/#{sub}"
    Spec::Rake::SpecTask.new(sub => spec_prereq) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList["spec/#{sub}/**/*_spec.rb"]
    end
  end

  desc "Run the code examples in vendor/plugins (except RSpec's own)"
  Spec::Rake::SpecTask.new(:plugins => spec_prereq) do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList['vendor/plugins/**/spec/**/*_spec.rb'].exclude('vendor/plugins/rspec/*').exclude("vendor/plugins/rspec-rails/*")
  end

  namespace :plugins do
    desc "Runs the examples for rspec_on_rails"
    Spec::Rake::SpecTask.new(:rspec_on_rails) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['vendor/plugins/rspec-rails/spec/**/*_spec.rb']
    end
  end

  # Setup specs for stats
  task :statsetup do
    require 'code_statistics'
    ::STATS_DIRECTORIES << %w(Model\ specs spec/models) if File.exist?('spec/models')
    ::STATS_DIRECTORIES << %w(View\ specs spec/views) if File.exist?('spec/views')
    ::STATS_DIRECTORIES << %w(Controller\ specs spec/controllers) if File.exist?('spec/controllers')
    ::STATS_DIRECTORIES << %w(Helper\ specs spec/helpers) if File.exist?('spec/helpers')
    ::STATS_DIRECTORIES << %w(Library\ specs spec/lib) if File.exist?('spec/lib')
    ::STATS_DIRECTORIES << %w(Routing\ specs spec/routing) if File.exist?('spec/routing')
    ::STATS_DIRECTORIES << %w(Integration\ specs spec/integration) if File.exist?('spec/integration')
    ::CodeStatistics::TEST_TYPES << "Model specs" if File.exist?('spec/models')
    ::CodeStatistics::TEST_TYPES << "View specs" if File.exist?('spec/views')
    ::CodeStatistics::TEST_TYPES << "Controller specs" if File.exist?('spec/controllers')
    ::CodeStatistics::TEST_TYPES << "Helper specs" if File.exist?('spec/helpers')
    ::CodeStatistics::TEST_TYPES << "Library specs" if File.exist?('spec/lib')
    ::CodeStatistics::TEST_TYPES << "Routing specs" if File.exist?('spec/routing')
    ::CodeStatistics::TEST_TYPES << "Integration specs" if File.exist?('spec/integration')
  end

  namespace :db do
    namespace :fixtures do
      desc "Load fixtures (from spec/fixtures) into the current environment's database.  Load specific fixtures using FIXTURES=x,y. Load from subdirectory in test/fixtures using FIXTURES_DIR=z."
      task :load => :environment do
        ActiveRecord::Base.establish_connection(Rails.env)
        base_dir = File.join(Rails.root, 'spec', 'fixtures')
        fixtures_dir = ENV['FIXTURES_DIR'] ? File.join(base_dir, ENV['FIXTURES_DIR']) : base_dir

        require 'active_record/fixtures'
        (ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/).map {|f| File.join(fixtures_dir, f) } : Dir.glob(File.join(fixtures_dir, '*.{yml,csv}'))).each do |fixture_file|
          Fixtures.create_fixtures(File.dirname(fixture_file), File.basename(fixture_file, '.*'))
        end
      end
    end
  end
end

end

}



file "spec/spec_helper.rb", %q{
# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

}

file "spec/fixtures/roles.yml", %q{
# Read about fixtures at http://ar.rubyonrails.org/classes/Fixtures.html

one:
  name: 
  authorizable_type: 
  authorizable_id: 1

two:
  name: 
  authorizable_type: 
  authorizable_id: 1

}

file "spec/spec.opts", %q{
--colour
--format progress
--loadby mtime
--reverse

}

file "spec/rcov.opts", %q{
--exclude "spec/*,gems/*"
--rails
}



file "public/stylesheets/sass/_user-navigation.sass", %q{
/* User navigation */

.app-user-navigation
  position: absolute
  right: 20px
  top: 0

  & ul
    list-style-type: none

    & li
      padding: 5px 10px
      float: left

      & a
        text-decoration: none
        &:visited, &:link
          color: #CDE
          border-bottom: 1px dotted #345
        &:hover
          border-bottom: 1px dotted #CDE
          color: #FFF

}

file "public/stylesheets/sass/_sidebar.sass", %q{
.app-sidebar .app-block
  margin-bottom: 20px

  h3
    background: #FFF
    border-bottom: 1px solid #CCC
    border-right: 1px solid #CCC
    border-left: 1px solid #DDD
    border-top: 1px solid #DDD
    padding: 5px 10px
    font-weight: bold

  ul.app-navigation
    list-style-type: none

    li a
      display: block
      padding: 5px 10px
      color: #6A6A6A
      text-decoration: none

      &:hover
        text-decoration: underline

  .app-content
    padding: 0 10px

    p
      margin: 15px 0
      color: #6A6A6A
        

}

file "public/stylesheets/sass/_layout.sass", %q{
html, body
  height: 100%
  color: #333
  font-family: "Lucida Grande","Helvetica Neue",Arial,sans-serif
  font-size: 0.9em
  line-height: 1.1em

.app-container
  background-color: #EBEBEB
  min-height: 100%
  margin-bottom: -52px

.app-header
  padding: 5px 20px
  background-color: #232C30

.app-header
  position: relative

.app-header h1
  font-size: 2.3em
  font-weight: normal
  padding: 5px 0
  margin: 5px 0

.app-header h1 a
  &, &:link, &:active, &:hover, &:visited
    color: #EAEAEA
    text-decoration: none

.app-wrapper
  padding: 20px 20px 0 20px

.app-main.app-has-sidebar
  float: left
  width: 73%

.app-sidebar
  float: right
  width: 25%

.app-footer
  height: 50px
  background-color: #DDD
  border-top: 1px solid #BBB
  padding: 0 10px

  & p
    text-align: right
    line-height: 20px
    margin: 15px 0

}

file "public/stylesheets/sass/application.sass", %q{
@import layout
@import user-navigation
@import main-navigation
@import flash
@import sidebar
@import table

}

file "public/stylesheets/sass/_main-navigation.sass", %q{
/* User navigation */

=main-navigation-link
  display: block
  padding: 3px 10px
  text-decoration: none

.app-main-navigation
  width: 100%

  & ul
    list-style-type: none

    & li
      background-color: #445566
      color: #EEEEEE
      border-top: 1px solid #5C738A
      margin-right: 5px
      float: left

      &:hover
        background-color: #576C82
        border-top: 1px solid #7593B0

      & a
        +main-navigation-link

        &:visited, &:link
          color: #FFFFFF

    & li.active
      background-color: #EEEEEE
      border-top: 1px solid #FFFFFF
      color: #364B69

      & a
      
        &:visited, &:link
          color: #364B69

}

file "public/stylesheets/sass/_table.sass", %q{
.app-table
  width: 100%

  thead tr

    th
      text-align: left
      white-space: nowrap
      color: #FFF
      background-color: #576C82
      font-weight: normal
      padding: 4px

  tbody

    tr

      td
        border-bottom: 1px solid #AAA
        padding: 2px

        a
          color: #07B
          text-decoration: none

        &.text
          text-align: left

        &.number
          text-align: right
          padding-right: 1em

        &.data
          text-align: left

        &.buttons
          text-align: center

      &:hover
        background-color: #FBFBFB

        
}

file "public/stylesheets/sass/formtastic_changes.sass", %q{
form.formtastic
  input[type="text"], input[type="password"], textarea, select
    background: #FFFFFF url(images/input.gif) repeat-x scroll 0 0
    border: 1px solid #E5E3D8
    padding: 3px
    -moz-box-sizing: border-box
    -webkit-box-sizing: border-box
    box-sizing: border-box

  input[type="submit"], input[type="button"]
    background: #FFFFFF url(images/input.gif) repeat-x scroll 0 0
    border: 1px solid #AAA
    padding: 3px

  abbr
    font-weight: bold
    font-size: 1.1em
    color: red

    &:before
      content: " "
}

file "public/stylesheets/sass/_flash.sass", %q{
.app-flash
  .flash-message
    -moz-border-radius: 3px
    -webkit-border-radius: 3px
    text-align: center
    margin: 0 auto 5px
    width: 80%

    p
      margin: 8px

  .error
    border: 1px solid #fbb
    background-color: #fdd

  .warning
    border: 1px solid #fffaaa
    background-color: #ffffcc

  .notice
    border: 1px solid #ddf
    background-color: #eef


}


file "public/stylesheets/clearfix.css", %q{
/* slightly enhanced, universal clearfix hack */
.clearfix:after {
     visibility: hidden;
     display: block;
     font-size: 0;
     content: " ";
     clear: both;
     height: 0;
}

.clearfix { display: inline-block; }

/* start commented backslash hack \*/
* html .clearfix { height: 1%; }

.clearfix { display: block; }
/* close commented backslash hack */
}


file "public/stylesheets/formtastic.css", %q{
/* -------------------------------------------------------------------------------------------------

It's *strongly* suggested that you don't modify this file.  Instead, load a new stylesheet after
this one in your layouts (eg formtastic_changes.css) and override the styles to suit your needs.
This will allow you to update formtastic.css with new releases without clobbering your own changes.

This stylesheet forms part of the Formtastic Rails Plugin
(c) 2008 Justin French

--------------------------------------------------------------------------------------------------*/


/* NORMALIZE AND RESET - obviously inspired by Yahoo's reset.css, but scoped to just form.formtastic
--------------------------------------------------------------------------------------------------*/
form.formtastic, form.formtastic ul, form.formtastic ol, form.formtastic li, form.formtastic fieldset, form.formtastic legend, form.formtastic input, form.formtastic textarea, form.formtastic select, form.formtastic p { margin:0; padding:0; }
form.formtastic fieldset { border:0; }
form.formtastic em, form.formtastic strong { font-style:normal; font-weight:normal; }
form.formtastic ol, form.formtastic ul { list-style:none; }
form.formtastic abbr, form.formtastic acronym { border:0; font-variant:normal; }
form.formtastic input, form.formtastic textarea, form.formtastic select { font-family:inherit; font-size:inherit; font-weight:inherit; }
form.formtastic input, form.formtastic textarea, form.formtastic select { font-size:100%; }
form.formtastic legend { color:#000; }


/* FIELDSETS & LISTS
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset { }
form.formtastic fieldset.inputs { }
form.formtastic fieldset.buttons { padding-left:25%; }
form.formtastic fieldset ol { }
form.formtastic fieldset.buttons li { float:left; padding-right:0.5em; }

/* clearfixing the fieldsets */
form.formtastic fieldset { display: inline-block; }
form.formtastic fieldset:after { content: "."; display: block; height: 0; clear: both; visibility: hidden; }
html[xmlns] form.formtastic fieldset { display: block; }
* html form.formtastic fieldset { height: 1%; }


/* INPUT LIs
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li { margin-bottom:1.5em; }

/* clearfixing the li's */
form.formtastic fieldset ol li { display: inline-block; }
form.formtastic fieldset ol li:after { content: "."; display: block; height: 0; clear: both; visibility: hidden; }
html[xmlns] form.formtastic fieldset ol li { display: block; }
* html form.formtastic fieldset ol li { height: 1%; }

form.formtastic fieldset ol li.required { }
form.formtastic fieldset ol li.optional { }
form.formtastic fieldset ol li.error { }
  

/* LABELS
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li label { display:block; width:25%; float:left; padding-top:.2em; }
form.formtastic fieldset ol li li label { line-height:100%; padding-top:0; }
form.formtastic fieldset ol li li label input { line-height:100%; vertical-align:middle; margin-top:-0.1em;}


/* NESTED FIELDSETS AND LEGENDS (radio, check boxes and date/time inputs use nested fieldsets)
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li fieldset { position:relative; }
form.formtastic fieldset ol li fieldset legend { position:absolute; width:25%; padding-top:0.1em; }
form.formtastic fieldset ol li fieldset legend span { position:absolute; }
form.formtastic fieldset ol li fieldset legend.label label { position:absolute; }
form.formtastic fieldset ol li fieldset ol { float:left; width:74%; margin:0; padding:0 0 0 25%; }
form.formtastic fieldset ol li fieldset ol li { padding:0; border:0; }


/* INLINE HINTS
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li p.inline-hints { color:#666; margin:0.5em 0 0 25%; }


/* INLINE ERRORS
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li p.inline-errors { color:#cc0000; margin:0.5em 0 0 25%; }
form.formtastic fieldset ol li ul.errors { color:#cc0000; margin:0.5em 0 0 25%; list-style:square; }
form.formtastic fieldset ol li ul.errors li { padding:0; border:none; display:list-item; }


/* STRING & NUMERIC OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.string input { width:74%; }
form.formtastic fieldset ol li.password input { width:74%; }
form.formtastic fieldset ol li.numeric input { width:74%; }


/* TEXTAREA OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.text textarea { width:74%; }


/* HIDDEN OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.hidden { display:none; }


/* BOOLEAN OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.boolean label { padding-left:25%; width:auto; }
form.formtastic fieldset ol li.boolean label input { margin:0 0.5em 0 0.2em; }


/* RADIO OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.radio { }
form.formtastic fieldset ol li.radio fieldset ol { margin-bottom:-0.6em; }
form.formtastic fieldset ol li.radio fieldset ol li { margin:0.1em 0 0.5em 0; }
form.formtastic fieldset ol li.radio fieldset ol li label { float:none; width:100%; }
form.formtastic fieldset ol li.radio fieldset ol li label input { margin-right:0.2em; }


/* CHECK BOXES (COLLECTION) OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.check_boxes { }
form.formtastic fieldset ol li.check_boxes fieldset ol { margin-bottom:-0.6em; }
form.formtastic fieldset ol li.check_boxes fieldset ol li { margin:0.1em 0 0.5em 0; }
form.formtastic fieldset ol li.check_boxes fieldset ol li label { float:none; width:100%; }
form.formtastic fieldset ol li.check_boxes fieldset ol li label input { margin-right:0.2em; }



/* DATE & TIME OVERRIDES
--------------------------------------------------------------------------------------------------*/
form.formtastic fieldset ol li.date fieldset ol li,
form.formtastic fieldset ol li.time fieldset ol li,
form.formtastic fieldset ol li.datetime fieldset ol li { float:left; width:auto; margin:0 .3em 0 0; }

form.formtastic fieldset ol li.date fieldset ol li label,
form.formtastic fieldset ol li.time fieldset ol li label,
form.formtastic fieldset ol li.datetime fieldset ol li label { display:none; }

form.formtastic fieldset ol li.date fieldset ol li label input, 
form.formtastic fieldset ol li.time fieldset ol li label input, 
form.formtastic fieldset ol li.datetime fieldset ol li label input { display:inline; margin:0; padding:0;  }

}


file "public/stylesheets/formtastic_changes.css", %q{
form.formtastic input[type="text"], form.formtastic input[type="password"], form.formtastic textarea, form.formtastic select {
  background: #FFFFFF url(images/input.gif) repeat-x scroll 0 0;
  border: 1px solid #E5E3D8;
  padding: 3px;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box; }
form.formtastic input[type="submit"], form.formtastic input[type="button"] {
  background: #FFFFFF url(images/input.gif) repeat-x scroll 0 0;
  border: 1px solid #AAA;
  padding: 3px; }
form.formtastic abbr {
  font-weight: bold;
  font-size: 1.1em;
  color: red; }
  form.formtastic abbr:before {
    content: " "; }

}


file "public/stylesheets/reset.css", %q{
/* http://meyerweb.com/eric/tools/css/reset/ */
/* v1.0 | 20080212 */

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	font-size: 100%;
	vertical-align: baseline;
	background: transparent;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}

/* remember to define focus styles! */
:focus {
	outline: 0;
}

/* remember to highlight inserts somehow! */
ins {
	text-decoration: none;
}
del {
	text-decoration: line-through;
}

/* tables still need 'cellspacing="0"' in the markup */
table {
	border-collapse: collapse;
	border-spacing: 0;
}

}



# Execute rake tasks
# rake "gems:install", :sudo => true
rake "secret"

# Initialize git repository
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"

