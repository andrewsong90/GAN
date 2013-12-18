class UserMailer < Devise::Mailer #ActionMailer::Base
 
  helper :application
  # "from" will be ignored in gmail smtp
  default from: "admin@gann.com"

  # Upon successful registration
  def welcome_email(user)
	 @user=user
	 mail(to: @user.email, subject:"[GAN] Welcome to the GAN - Gann Alumni Networks!!!")	
  end

  def opportunity_email(user)
  end

  def confirmation_instructions(record,token,opts={})
    opts[:subject]="[GAN] Confirm GAN account"
    super
  end

  # When an application is submitted
  def submission_email(user,application,index_of_uploads)
  	@user, @application, @opportunity =user, application, application.opportunity
    

    index_of_uploads.each do |index|
      upload=Userupload.find(index)
      attachments << (attachments[upload.avatar_file_name] = File.open(upload.avatar.path, 'rb'){|f| f.read })
    end
  	
    mail(to: @user.email , bcc: @opportunity.user.email, subject:"[GAN] Application has been submitted")
  end

end
