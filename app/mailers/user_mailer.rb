class UserMailer < ActionMailer::Base
  default from: "mailer@gann.com"

  def welcome_email(user)
	@user=user
	mail(to: @user.email, subject:"Welcome to the GAN - Gann Alumni Networks!!!")	
  end
end
