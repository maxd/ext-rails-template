class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)  
  end
  
end
