class UserMailer < Devise::Mailer #ActionMailer::Base
 
  helper :application
  # "from" will be ignored in gmail smtp (in this case development)
  default from: "no-reply@gann.com"

  # Upon successful registration
  def welcome_email(user)
	 @user=user
	 mail(to: @user.email, subject:"[GAN] Welcome to the GAN - Gann Alumni Networks!!!")	
  end

  def contact_email_to_user(contact)
    @contact=contact
    mail(to: @contact.from_email, subject:"[GAN] #{@contact.title}")
  end

  def contact_email_to_admin(contact)
    @contact=contact
    mail(to: "alumni@gannacademy.org", subject:"[GAN] #{@contact.title}")
  end

  def invite_message(user, token, title, content)
    @user = user
    @title = title
    @content = content
    @invitation_link = accept_user_invitation_url(:invitation_token => token)
    mail(to: @user.email, subject: @title)
  end

  # Send out emails to all users when announcement is made
  def announcement_email(post)
    @post=post
    users=Alum.all.map(&:email)
    mail(to: users, subject:"[GAN Announcement] #{@post.title}")
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
  	
    mail(to: @user.email , bcc: bcc_recepients , subject:"[GAN] Application has been submitted")

    logger.debug("SENT!")
    
    # This is to destroy the attachment right away
    @application.upload.destroy
    @application.upload = nil
  end

end
