class ReportMailer < ActionMailer::Base
  default from: "notetato.app@gmail.com"

  def focus_email(recipient, focus)
    @recipient = recipient
    @url  = 'http://notetato.com'
    @focus = focus
    mail(to: @recipient.email, subject: "Today's focus")
  end

end
