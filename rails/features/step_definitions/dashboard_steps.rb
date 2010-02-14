Then /^I should see dashboard page$/ do
  response.should have_selector("div.app-container")
end