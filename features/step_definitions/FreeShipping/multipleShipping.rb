#Checking Page Navigation is successful or not
Then /^I verify the user is in the "([^"]*)" page$/ do |pagetitle|
  @pagetitle = pagetitle
  page_navigated = page.has_content?pagetitle 
  if (page_navigated.should == true)
    @log.debug("navigated to the page: " + @pagetitle)
    @log.debug("\n") 
  end
  @log.debug("Verifiaction of page navigation done")
end

#Checkout steps
And /^I checkout$/ do
  wait_until{page.find(:xpath, @xpath['checkout_btn']).visible?}
  page.find(:xpath, @xpath['checkout_btn']).click
end

And /^I continue to checkout$/ do
  wait_until{page.find(:xpath, @xpath['continue_checkout_btn']).visible?}
  page.find(:xpath, @xpath['continue_checkout_btn']).click
end

And /^I verify for free shipping$/ do
  testfree=page.find(:xpath, @xpath['shipping_charge_price']).text.match(@value['txt_free'])
  if(testfree.should_not == nil)
    @log.debug("Amount displayed for the standard shipping is FREE.Step passed")
  end
end

#Selecting multiple address shipping
And /^I click on the multiple address shipping$/ do
  page.find(:xpath, @xpath['shipping_multiple_address']).click
  wait_until{page.find(:xpath, @xpath['continue']).visible?}
  page.find(:xpath, @xpath['continue']).click
end

And /^I select the item$/ do
  page.find(:xpath, @xpath['radio_item']).click
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
end

And /^I confirm the address$/ do
  wait_until{page.find(:xpath, @xpath['continue']).visible?}
  page.find(:xpath, @xpath['continue']).click
end

#Checking Standard, Premium and Express Shipping Charges
And /^I verify the various shipping options as "([^"]*)", "([^"]*)", "([^"]*)"$/ do |std, pre, exp|
  #Standard Charge
  teststd = page.find(:xpath, @xpath['shipping_charge_price']).text.match(std)
  if(teststd.should_not == nil)
    @log.debug("Amount displayed for the standard shipping is correct")
  end
  
  if page.has_xpath?@xpath['shipping_method2']
    #Premium Charge
    page.find(:xpath, @xpath['shipping_method2']).click
    wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
    testpremium = page.find(:xpath, @xpath['shipping_charge_price']).text.match(pre)
    if(testpremium.should_not == nil)
      @log.debug("Amount displayed for the premium shipping is correct")
    end
    
    #Express Charge
    wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
    page.find(:xpath, @xpath['shipping_method3']).click
    wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
    testexpress = page.find(:xpath, @xpath['shipping_charge_price']).text.match(exp)
    if(testpremium.should_not == nil)
      @log.debug("Amount displayed for the express shipping is correct")
    end
  else
    @log.debug("Premium and Express shipping not available for the selected product")
    break
  end
end

#Shipping details for Shipment #2
And /^I select one of the shipping options$/ do
  wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
  page.find(:xpath, @xpath['shipping_method2']).click
  wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
end

And /^I select the item for shipment #2$/ do
  page.find(:xpath, @xpath['radio_item']).click
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
end

And /^I select the second address$/ do 
  page.find(:xpath, @xpath['shipping_address_wishlist']).click
page.find(:xpath, @xpath['continue']).click
end

And /^I select one of the shipping options for shipping#2$/ do
  wait_until{page.find(:xpath, @xpath['shipping_method1']).visible?}
  page.find(:xpath, @xpath['shipping_method1']).click
  wait_until{page.find(:xpath, @xpath['shipping_method1']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
end

And /^I click on continue checkout$/ do
  wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
  page.find(:xpath, @xpath['continue_checkout']).click
end

And /^I enter the secret code$/ do 
  fill_in @xpath['field_sec_id'], :with => @value['val_sec_id']  
end