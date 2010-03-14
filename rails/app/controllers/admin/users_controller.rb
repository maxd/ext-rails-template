class Admin::UsersController < Admin::Application

  navigation :users
  sidebar

  before_filter :load_user, :only => [ :edit, :update, :destroy ]

  def index
    @users = User.all(:order => "login ASC").paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy if @user.login != "admin"

    redirect_to admin_users_path
  end

private

  def load_user
    @user = User.find(params[:id])
  end

end
