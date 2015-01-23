class ReportMailer < ActionMailer::Base
  default from: "notetato.app@gmail.com"
  # default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"

  def focus_email(recipient, focus)
    @recipient = recipient
    @url  = 'http://notetato.com'
    @focus = focus
    mail(to: @recipient.email, subject: "Your Daily Focus Report")
  end

end
