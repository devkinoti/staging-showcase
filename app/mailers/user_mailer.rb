class UserMailer < ActionMailer::Base
  default from: "sbs@example.com"

  def signup_confirmation(user)
  	@user = user
  	@greeting = "Hi"

  	mail to: user.email,subject: "Sign in confirmation", date: Date.today
  end
end
