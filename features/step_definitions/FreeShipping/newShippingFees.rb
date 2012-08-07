#MCOM-77000
#Enter the user name and password
Then /^I should be able to enter "([^"]*)" and "([^"]*)" & click signin$/ do |userName, password|
   fill_in @xpath['signin_email'], :with => userName
   fill_in @xpath['signin_password'], :with => password
   page.find(:xpath, @xpath['sign_in_home_page']).click
   @log.debug("Signing in completed")
end


#Navigating to the Shipping Address page
When /^I navigate to shopping bag then to shippping address page$/ do
  wait_until{page.find(:xpath, @xpath['checkout_toplink']).visible?}
  page.find(:xpath, @xpath['checkout_toplink']).click
  wait_until{page.find(:xpath, @xpath['shopping_bag_footer']).visible?}
  pdtCount = page.all(:css, "#itemsContainer .secondary", :visible => true).count
  pdtCount = pdtCount.to_i
  if pdtCount > 1
    for i in 2..pdtCount
      puts "in for"
      page.find(:xpath, @xpath[shopping_bag_remove_link]).click
      wait_until{page.find(:xpath, @xpath['shopping_bag_content']).visible?}
    end
  end
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
  @log.debug("Shipping Address navigation")
end

#Searching for a text in a page
Then /^I should see the "([^"]*)"$/ do |text|
  $searchText = text
  $searchResult = page.has_content?text 
end

Then /^I should see in the order summary "([^"]*)"$/ do |shipCharge|
  wait_until{page.find(:xpath, @xpath['shipping_address_summary']).visible?}
  shippingCost = page.find(:xpath, @xpath['shipping_charges_summary']).text
  if shippingCost.should == shipCharge
    @log.debug("#{shipCharge} found")
  end
end

#Navigating to the Shipping Options page
And /^I navigate to Shipping Options page$/ do 
  wait_until{page.find(:xpath, @xpath['continue']).visible?}
  page.find(:xpath, @xpath['continue']).click
  @log.debug("Shipping options page")
end

And /^I navigate to the other checkout pages$/ do
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}   
  page.find(:xpath, @xpath['continue_checkout']).click
  fill_in @xpath['field_sec_id'], :with => @value['val_sec_id']
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
  @log.debug("Other checkout pages")
end

#Navigating back to Shipping Options page
Then /^I navigate back to Shippping Options page$/ do
  wait_until{page.find(:xpath, @xpath['back_one_step']).visible?}
  page.find(:xpath, @xpath['back_one_step']).click
  wait_until{page.find(:xpath, @xpath['back_one_step']).visible?}
  page.find(:xpath, @xpath['back_one_step']).click
  @log.debug("Navigated back to Shipping Options page")
end

#Checking other shipping options
And /^I click the Premium Shipping$/ do 
  wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
  page.find(:xpath, @xpath['shipping_method2']).click
  @log.debug("Selecting Premium Shipping")
end

And /^I click the Express Shipping$/ do 
  wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
  page.find(:xpath, @xpath['shipping_method3']).click
  @log.debug("Selecting Express Shipping")
end