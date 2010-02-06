Then /^I should be registered in application$/ do
  controller.current_user.should_not be_nil
  controller.current_user.login.should == "user"
  controller.current_user.email.should == "user@example.com"
end

Then /^(?:|I )should not be registered in application$/ do
  controller.current_user.should be_nil
end
