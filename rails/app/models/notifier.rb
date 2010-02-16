class Notifier < ActionMailer::Base

  def password_reset_instructions(user)
    subject       I18n.t("title_of_reset_password_email")
    from          FROM_EMAIL_ADDRESS
    recipients    user.email
    sent_on       Time.now
    body          :reset_password_url => reset_password_url(user.perishable_token)
  end

end
