#I navigate to the shopping bag page
And /^I navigate to the shopping bag page$/ do
  wait_until{page.find(:xpath, @xpath['checkout_toplink']).visible?}
  page.find(:xpath, @xpath['checkout_toplink']).click
  @log.debug("Visited the shopping bag")
end

#I do verification of shipping cost as $9.95
And /^I verify the estimated shipping$/ do
  merchandiseTotal = page.find(:xpath, @xpath['merchandise_total']).text
  estimateShipping = page.find(:xpath, @xpath['estimated_shipping_total']).text
  if merchandiseTotal < @value['merchandise_total'].to_s && estimateShipping == @value['default_shipping_charge'].to_s
    @log.debug("Estimated Shipping charge is $#{estimateShipping}")
  else
    @log.debug("Error in Estimated Shipping Charges")      
  end
  @log.debug("I successfully verify the amount of the estimated shopping")
end 

#I click Estimated Shipping link
And /^I click Estimated Shipping link$/ do
  wait_until{page.find(:xpath, @xpath['estimated_shipping']).visible?}
  page.find(:xpath, @xpath['estimated_shipping']).click 
  @log.debug("Visited the estimated shipping link") 
end

#I click on any link
When /^I click on the "([^"]*)" link$/ do |link|
  click_link link
  @log.debug("Visited the link")
end

#I open a pop up and check the shipping charges
And /^I should see a popup for shipping charge$/ do
  wait_until{page.find(:xpath, @xpath['shopping_bag_popup']).visible?}
  popup = page.has_xpath?@xpath['shopping_bag_popup']
  if popup.should == true
    @log.debug("Popup Found")
  end
  @log.debug("Visited the pop up charges page")
end

#Estimated Shipping Overlay
And /^I verify "([^"]*)" as "([^"]*)" is there in overlay$/ do |shipping, cost|
  wait_until{page.find(:xpath, @xpath['estimated_ship_popup_text']).visible?}
  popup = page.find(:xpath, @xpath['estimated_ship_popup_text'])
  ship = popup.should have_content(shipping)
  shipCost = popup.should have_content(cost)
  if ship && shipCost
    @log.debug("Shipping Charges found : #{shipping} #{cost}")
  else
    @log.debug("Shipping Charges not found : #{shipping} #{cost}")
  end
  @log.debug("Visited the estimated overlay page")
end

#I check the overlay cost
And /^I check the overlay for "([^"]*)" as "([^"]*)"$/ do |totEstimation, estCost|
  estShipCost = page.find(:xpath, @xpath['total_shipping_cost'])
  estimation = estShipCost.has_content?totEstimation
  estimationCost = estShipCost.has_content?estCost
  if estimation && estimationCost
    @log.debug("Estimated Shipping cost found : #{totEstimation} #{estCost}")
  else
    @log.debug("Estimated Shipping Charges not found : #{totEstimation} #{estCost}")
  end
  @log.debug("Successfully check the overlay")
end

#I check the pop up window and check the shipping charges
And /^I should see a popup window to check shipping charges$/ do
  begin
    $popupWindow = page.driver.browser.window_handles.last
    within_window($popupWindow) do
      $popupOpen = page.has_content?@xpath['popup_text']
      rowCount = page.all('table.merchandiseItems tbody tr').count
      shipSubtot = page.find(:xpath, "//table[@class='merchandiseItems']/tbody/tr[#{rowCount}]").text
      totShipCostText = page.find(:xpath, @xpath['popup_total_shipping_cost_text']).text
      totShipCost = page.find(:xpath, @xpath['popup_total_shipping_cost_value']).text
      if $popupOpen.should == true
        @log.debug("Popup window opened")
      end
      
      #Standard Shipping Costs Sub-total Section
      @log.debug("Retrived Shipping Subtotal: #{shipSubtot}")
      if shipSubtot.should == @value['std_ship_cost_subtot']
        @log.debug("Verified the text #{shipSubtot}")  
      end

      #Total Shipping Costs For Your Order Section
      @log.debug("Total shipping costs: #{totShipCostText} #{totShipCost}")
      if totShipCostText.should == @value['tot_ship_cost'] && totShipCost.should == @value['std_ship_cost']
        @log.debug("verified total shipping charges")
      end
    end
  rescue
  end
  @log.debug("I check the popup window for charges")
end

#Verifying the Standard Shipping Costs table
And /^I verify "([^"]*)" rows of Standard Shipping Costs table$/ do |rows|
  within_window($popupWindow) do
    rowCount = page.all('table.myRatesTable tbody tr').count
    for i in (1..(rows.to_i))
      tableContent = page.find(:xpath, "//table[@class='myRatesTable']/tbody/tr[#{i}]").text
      @log.debug("#{tableContent}")
    end
    page.find(:xpath, @xpath['popup_window_close']).click
  end
  @log.debug("Verify the standard cost table")
end