class Admin::UsersController < Admin::BaseController
	before_action :find_user, :only => [:show,:edit,:update,:destroy]
  layout "admin/admin"
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      UserMailer.signup_confirmation(@user).deliver
  		flash[:notice] = "User created successfully"
  		redirect_to admin_users_path
  	else
  		flash[:alert] = "User has not been created"
  		render :action => "new"
  	end
  end

  def show
  end

  def edit
  end

  def update
  	if params[:user][:password].blank?
  		params[:user].delete(:password)
  	end

  	if @user.update_attributes(user_params)
  		flash[:notice] = "User has been updated successfully"
  		redirect_to admin_users_path 
  	else
  		flash[:alert] = "User has not been updated"
  		render :action => "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:first_name,:last_name,:email,:password,:admin)
  end

  def find_user
  	@user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for does not exist"
    redirect_to admin_users_path
  end
end
