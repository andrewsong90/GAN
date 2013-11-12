class UserMailer < ActionMailer::Base
  # "from" will be ignored in gmail smtp
  default from: "mailer@gann.com"

  def welcome_email(user)
	@user=user
	mail(to: @user.email, subject:"[GAN] Welcome to the GAN - Gann Alumni Networks!!!")	
  end

  def opportunity_email(user)
  end

  def submission_email(user,application)
  	@user, @application, @opportunity =user, application, application.opportunity
  	mail(to: @opportunity.user.email, cc: @user.email, subject:"[GAN] Application has been submitted")
  end
end
