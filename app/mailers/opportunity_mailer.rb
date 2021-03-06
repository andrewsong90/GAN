class OpportunityMailer < ActionMailer::Base
  helper :application
  # "from" will be ignored in gmail smtp (in this case development)
  default from: "no-reply@gann.com"

  def opportunity_created_email(opportunity)
    attachments.inline['gann_banner.png']=File.read("#{Rails.root.to_s}/app/assets/images/gann_banner.png")
  	@opportunity = opportunity
  	mail(to: @opportunity.user.email, subject: "[GAN] Opportunity created - #{@opportunity.title}")
  end

  def opportunity_updated_email(opportunity)
  	
  end

  def opportunity_push_email(opportunity,user)
    attachments.inline['gann_banner.png']=File.read("#{Rails.root.to_s}/app/assets/images/gann_banner.png")
    @opportunity = opportunity
    @user=user
    mail(to: @user.email, subject:"[GAN] New opportunity created! - #{@opportunity.title}")
  end
end
