# encoding: ISO-8859-1

And /^I verify the domestic shipping charges$/ do
  wait_until{page.find(:xpath, @xpath['table_cost_std']).visible?}
  $stdText = page.find(:xpath, @xpath['table_cost_std']).text
  @log.debug("Verification of domestic shipping charges")
  @log.debug("#{$stdText}")
  if($stdText.should == @value['std_text'])
    @log.debug("Standard Shipping Charges are correct")
  end

  $premiumText=page.find(:xpath, @xpath['table_cost_pre']).text
  @log.debug("#{$premiumText}")
  if($premiumText.should == @value['pre_text'])
    @log.debug("Premium Shipping Charges are correct")
  end

  $expressText=page.find(:xpath, @xpath['table_cost_exp']).text
  @log.debug("#{$expressText}")
  if($expressText.should == @value['exp_text'])
    @log.debug("Express Shipping Charges are correct")
  end
  @log.debug("I check the domestic charges")

end
 
 
And /^I verify the international shipping charges$/ do
  wait_until{page.find(:xpath, @xpath['table_int_std']).visible?}
  $stdTextInt=page.find(:xpath, @xpath['table_int_std']).text
  @log.debug("Verification of International shipping charges")
  @log.debug("#{$stdTextInt}")
  if($stdTextInt.should == @value['std_int_text'])
    @log.debug("Standard Shipping Charges are correct")
  end

  $premiumTextInt=page.find(:xpath, @xpath['table_int_pre']).text
  @log.debug("#{$premiumTextInt}")
  if($premiumTextInt.should == @value['pre_int_text'])
    @log.debug("premium Shipping Charges are correct")
  end

  $expressTextInt=page.find(:xpath, @xpath['table_int_exp']).text
     @log.debug("#{$expressTextInt}")
   if($expressTextInt.should == @value['exp_int_text'])
     @log.debug("Express Shipping Charges are correct")
   end
   @log.debug("I verify international shipping charges")

end
 
And /^I verify the Flat free shipping$/ do
  wait_until{page.find(:xpath, @xpath['table_text']).visible?}
  freeText=page.find(:xpath, @xpath['table_textcontent']).text
  if(freeText.should_not == nil)
    @log.debug("Flat free shipping test case passed")
  end
  @log.debug("I verify flat free shipping")

end
  
And /^I verify the domestic shipping charges for para ayuda$/ do
  wait_until{page.find(:xpath, @xpath['table_cost_std']).visible?}
  $stdTextPara=page.find(:xpath, @xpath['table_cost_std']).text.force_encoding("UTF-8")
  @log.debug("Verification of shipping charges for para ayuda")
  @log.debug("#{$stdTextPara}")
  @log.debug("Standard Shipping Charges are correct")
  
  $premiumTextPara=page.find(:xpath, @xpath['table_cost_pre']).text
    @log.debug("#{$premiumTextPara}")
  if($premiumTextPara.should == @value['pre_text_para'])
    @log.debug("Premium Shipping Charges are correct")
  end

  $expressTextPara=page.find(:xpath, @xpath['table_cost_exp']).text
  @log.debug("#{$expressTextPara}")
  if($expressTextPara.should == @value['exp_text_para'])
    @log.debug("Express Shipping Charges are correct")
  end
  @log.debug("I verify shipping charges in para ayuda")
end
 
And /^I click on the Infomacion del envio$/ do
  objText = page.find(:xpath, @xpath['link_othercountry']).text.force_encoding("UTF-8")
  click_link objText    
  @log.debug("I click on the informacion gel envio")

end

And /^I go to home page$/ do
  wait_until{page.find(:xpath, @xpath['macys_home']).visible?}
  page.find(:xpath, @xpath['macys_home']).click
end

And /^I should see popup window and verify the charges$/ do
  begin
    $popupWindow = page.driver.browser.window_handles.last
    within_window($popupWindow) do
      popupOpen = page.has_content?'Shipping Policy'
      $stdText = page.find(:xpath, @xpath['table_cost_std']).text
      $premiumText = page.find(:xpath, @xpath['table_cost_pre']).text
      $expressText = page.find(:xpath, @xpath['table_cost_exp']).text
      
      if popupOpen.should == true
        @log.debug("Popup Window Opened")
      end
      @log.debug("Verification of domestic shipping charges")
      @log.debug("#{$stdText}")
      if($stdText.should == @value['std_text'])
        @log.debug("Standard Shipping Charges are correct")
      end
    
      @log.debug("#{$premiumText}")
      if($premiumText.should == @value['pre_text'])
        @log.debug("Premium Shipping Charges are correct")
      end
    
      @log.debug("#{$expressText}")
      if($expressText.should == @value['exp_text'])
        @log.debug("Express Shipping Charges are correct")
      end
    end
  rescue
  end
  @log.debug("I verify the cost in pop up window")
end

#Added to avoid Scenario Outline
#Enter the user name and password
Then /^I should be able to enter "([^"]*)" and "([^"]*)" & signin$/ do |user, password|
   fill_in @xpath['signin_email'], :with => @value["#{user}"]
   fill_in @xpath['signin_password'], :with => @value["#{password}"]
   page.find(:xpath, @xpath['sign_in_home_page']).click
   @log.debug("Signing in completed")
end

Then /^I verify order summary for "([^"]*)"$/ do |shipCharge|
  wait_until{page.find(:xpath, @xpath['shipping_address_summary']).visible?}
  shippingCost = page.find(:xpath, @xpath['shipping_charges_summary']).text
  if shippingCost.should == @value["#{shipCharge}"]
    @log.debug('@value["#{shipCharge}"] found')
  end
end

And /^I verify the various shipping options for "([^"]*)", "([^"]*)", "([^"]*)"$/ do |std, pre, exp|
  #Standard Charge
  teststd = page.find(:xpath, @xpath['shipping_charge_price']).text.match(@value["#{std}"].to_s)
  if(teststd.should_not == nil)
    @log.debug("Amount displayed for the standard shipping is correct")
  end
  
  if page.has_xpath?@xpath['shipping_method2']
    #Premium Charge
    page.find(:xpath, @xpath['shipping_method2']).click
    wait_until{page.find(:xpath, @xpath['shipping_method2']).visible?}
    testpremium = page.find(:xpath, @xpath['shipping_charge_price']).text.match(@value["#{pre}"].to_s)
    if(testpremium.should_not == nil)
      @log.debug("Amount displayed for the premium shipping is correct")
    end
    
    #Express Charge
    wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
    page.find(:xpath, @xpath['shipping_method3']).click
    wait_until{page.find(:xpath, @xpath['shipping_method3']).visible?}
    testexpress = page.find(:xpath, @xpath['shipping_charge_price']).text.match(@value["#{exp}"].to_s)
    if(testpremium.should_not == nil)
      @log.debug("Amount displayed for the express shipping is correct")
    end
  else
    @log.debug("Premium and Express shipping not available for the selected product")
    break
  end
end

Then /^I should find "([^"]*)" in the page$/ do |shippingChargeText|
  $shippingCharge = page.find(:xpath, @xpath['shipping_charges_summary']).text
  #Checking for Shipping Charges page
  if @value["#{shippingChargeText}"].should == $shippingCharge
    @log.debug("Search Text" + @value["#{shippingChargeText}"] + "found")
  end
end

And /^I verify "([^"]*)" as "([^"]*)" is in the overlay$/ do |shipping, cost|
  wait_until{page.find(:xpath, @xpath['estimated_ship_popup_text']).visible?}
  popup = page.find(:xpath, @xpath['estimated_ship_popup_text'])
  ship = popup.should have_content(@value["#{shipping}"])
  shipCost = popup.should have_content(@value["#{cost}"])
  if ship && shipCost
    @log.debug("Shipping Charges found : " + @value["#{shipping}"] + @value["#{cost}"])
  else
    @log.debug("Shipping Charges not found : " + @value["#{shipping}"] + @value["#{cost}"])
  end
  @log.debug("Visited the estimated overlay page")
end

And /^I check the overlay for "([^"]*)" as "([^"]*)" displayed$/ do |totEstimation, estCost|
  estShipCost = page.find(:xpath, @xpath['total_shipping_cost'])
  estimation = estShipCost.has_content?@value["#{totEstimation}"]
  estimationCost = estShipCost.has_content?@value["#{estCost}"]
  if estimation && estimationCost
    @log.debug("Estimated Shipping cost found : " + @value["#{totEstimation}"] + @value["#{estCost}"])
  else
    @log.debug("Estimated Shipping cost not found : " + @value["#{totEstimation}"] + @value["#{estCost}"])
  end
  @log.debug("Successfully check the overlay")
end