class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	store_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def authorize_admin!
  	authenticate_user!
  	unless current_user.admin?
  		flash[:alert] = "You dont have admin rights to do that"
  		redirect_to dashboard_path
  	end
  end
end
