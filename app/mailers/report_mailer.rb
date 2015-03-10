class ReportMailer < ActionMailer::Base
  default from: "notetato.app@gmail.com"
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"


  def moments_email(recipient, moments)
    @recipient = recipient
    @url  = 'http://notetato.com'
    @moments = moments
    mail(to: @recipient.email, subject: "Your Daily Report")
  end


  ########################################
  ### Entries and Focus are phased out ###
  ########################################
  # def focus_email(recipient, focus)
  #   @recipient = recipient
  #   @url  = 'http://notetato.com'
  #   @focus = focus
  #   mail(to: @recipient.email, subject: "Your Daily Focus Report")
  # end

end
