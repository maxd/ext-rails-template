Then /^(?:|I )should see "([^\"]*)" link$/ do |link|
  response.should have_xpath("//a[@href='#{link}']")
end

Then /^"([^\"]*)" link$/ do |link|
  response.should have_xpath("//a[@href='#{link}']")
end

Then /^(?:|I )should see form validation for "([^\"]*)"(?:| field)$/ do |field|
  response.should have_xpath("//p[@class='inline-errors']/parent::node()/label[contains(.,'#{field}')]")  
end

Then /^(?:|I )should see flash with "([^\"]*)"$/ do |text|
  response.should have_xpath("//div[starts-with(@class, 'flash-message')]/p[contains(.,'#{text}')]")  
end

Then /^I should be able to log in with login "([^\"]*)" and password "([^\"]*)"$/ do |login, password|
  UserSession.new(:login => login, :password => password).save.should == true
end
