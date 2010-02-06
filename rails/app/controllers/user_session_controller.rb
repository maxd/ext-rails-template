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
