class UserMailer < Devise::Mailer #ActionMailer::Base
 
  helper :application
  # "from" will be ignored in gmail smtp
  default from: "no-reply@gann.com"

  # Upon successful registration
  def welcome_email(user)
	 @user=user
	 mail(to: @user.email, subject:"[GAN] Welcome to the GAN - Gann Alumni Networks!!!")	
  end

  def contact_email(contact)
    @contact=contact
    mail(to: @contact.from_email, bcc: "alumni@gannacademy.org", subject:"[GAN] #{@contact.title}")
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

    if @application.upload.path!= nil
      attachments << (attachments[@application.upload_file_name] = File.open(@application.upload.path, 'rb'){|f| f.read })
    end

    if index_of_uploads!=nil
      index_of_uploads.each do |index|
        upload=Userupload.find(index)
        attachments << (attachments[upload.avatar_file_name] = File.open(upload.avatar.path, 'rb'){|f| f.read })
      end
    end

    bcc_recepients = [@opportunity.user.email]
    @opportunity.sponsors.all.to_a.each do |sponsor|
      bcc_recepients << sponsor.email
    end

    logger.debug("SPONSORS #{bcc_recepients}")
  	
    mail(to: @user.email , bcc: bcc_recepients , subject:"[GAN] Application has been submitted")

    logger.debug("SENT!")
    @application.upload.destroy
    @application.upload = nil
  end

end
