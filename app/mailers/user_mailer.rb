class UserMailer < ActionMailer::Base
  default from: "SBS_shop_application@SBS_shop_app.com"

  def signup_confirmation(user)
  	@user = user
  	attachments["products-#{Time.current.strftime("%d-%b-%Y")}.csv"] = File.read(Rails.root.join('public','csv',"products.csv"))
  	mail to: user.email,subject: "Sign in confirmation", date: Date.today
  end
end
