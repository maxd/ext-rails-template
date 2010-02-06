class Notifier < ActionMailer::Base

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "noreplay@domain.com"
    recipients    user.email
    sent_on       Time.now
    body          :reset_password_url => reset_password_url(user.perishable_token)
  end

end
