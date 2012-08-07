#Navigating to Shipping Address page
And /^I navigates to shipping address page$/ do
  page.find(:xpath, @xpath['new_address']).click
  page.find(:xpath, @xpath['shipping_address_default']).click
  @log.debug("Navigated to shipping page")
end  

#Verifying the Shipping Charges
Then /^I should find "([^"]*)"$/ do |shippingChargeText|
  $shippingCharge = page.find(:xpath, @xpath['shipping_charges_summary']).text
  #Checking for Shipping Charges page
  if shippingChargeText.should == $shippingCharge
    @log.debug("Search Text '#{$shippingCharge}' found")
  end
  @log.debug("verified the shipping charges")
end

When /^I navigate to shipping options page$/ do
  wait_until{page.find(:xpath, @xpath['continue']).visible?}
  page.find(:xpath, @xpath['continue']).click
  @log.debug("Navigate to shipping options page")
end

#Verifying the standard, premium, express charges
And /^I should see the standard, premium, express charges$/ do
    #Clicking Standard Option
    $standardCharge = page.find(:xpath, @xpath['shipping_charge_price']).text
    @log.debug("#{$standardCharge}")
    
    #Clicking Premium Option
    page.find(:xpath, @xpath['shipping_method2']).click
    wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
    $premiumCharge = page.find(:xpath, @xpath['shipping_charge_price']).text
    @log.debug("#{$premiumCharge}")
    
    #Clicking Express Option
    page.find(:xpath, @xpath['shipping_method3']).click
    wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
    $expressCharge = page.find(:xpath, @xpath['shipping_charge_price']).text
    @log.debug("#{$expressCharge}")
  @log.debug("Successfully verified the charges")
end 

And /^I navigate to the billing page$/ do   
  if($standardCharge.should == @value['txt_free'] && $premiumCharge.should == @value['pre_charge'] && $expressCharge.should == @value['exp_charge'])
    page.find(:xpath, @xpath['continue_checkout']).click
    fill_in @xpath['field_sec_id'] , :with => @value['val_sec_id']
    page.find(:xpath, @xpath['continue_checkout']).click 
  end
  @log.debug("navigation to billing page")
end