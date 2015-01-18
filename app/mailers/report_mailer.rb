class ReportMailer < ActionMailer::Base
  default from: "notetato.app@gmail.com"

  def focus_email(recipient)
    @recipient = recipient
    @url  = 'http://notetato.com'
    mail(to: @recipient.email, subject: "Today's focus")
  end

end
