# I click on the menu
And /^I click on women$/ do
  wait_until{page.find(:xpath, @xpath['menu_women']).visible?}
  page.find(:xpath, @xpath['menu_women']).click
  @log.debug("Navigated to women page")
end

#I select a particular price range
And /^I click on the price range "([^"]*)"$/ do |range|
  page.find(:css, '#priceFacetValues li span', :text => range).click
  @log.debug("Navigated to the price range")
end

#I select a item from the list
And /^I select a item$/ do
   fill_in @xpath['search_text'], :with => @xpath['women_dress']
   #click_button @xpath['search_button']
   #wait_until{page.find(:xpath, @xpath['search_button']).visible?}
   page.find(:xpath, @xpath['search_button']).click
   wait_until{page.find(:xpath, @xpath['women_menu_dress']).visible?}
   page.find(:xpath, @xpath['women_menu_dress']).click
   @log.debug("Selected an Item")
end

#I add the item to the bag with some quantity  
Then /^I add the item to the bag with quantity "([^"]*)"$/ do |quantity|
  page.find(:css,'#pdpAttributes div div ul li span',:text => @value['size_dress'].to_s).click
  select(quantity, :from=> @xpath['product_quantity'])
  wait_until{page.find(:xpath, @xpath['add_to_bag_img']).visible?}
  page.find(:xpath, @xpath['add_to_bag_img']).click
  @log.debug("Added the Item to the bag")
end
 
#I verify if the item is successfully added to the bag 
And /^I verify if the item is successfully added to the "([^"]*)" bag$/ do |baglink|
  click_link baglink
  wait_until{page.find(:xpath, @xpath['product_url']).visible?}
  prdName=page.find(:xpath, @xpath['product_url']).text
  if(prdName==@xpath['women_dress'])
    @log.debug("Item successfully added to bag")
    @log.debug("#{prdName}")
    @log.debug("Product found in the bag")
  else
    @log.debug("item not successfully added to bag")
    @log.debug("Product Not found in the bag")
  end
end

#I verify if there is free shipping for the product in bag total  
And /^I verify if there is a free shipping$/ do
  wait_until{page.find(:xpath, @xpath['bag_estimated_total']).visible?}
  $shipCost=page.find(:xpath, @xpath['bag_estimated_total']).text
  if($shipCost==@xpath['free_ship_charge'])
    @log.debug("Shipping cost without promo is #{$shipCost}")
    @log.debug("Test case passed")
    @log.debug("Free shipping checked successfully")
  else
    @log.debug("Shipping cost without promo is #{$shipCost}")
    @log.debug("Test case failed")
    @log.debug("Free shipping has cost")
  end
end

#I verify for free shipping in all pages      
And /^I verify if the cost is free$/ do
   wait_until{page.find(:xpath, @xpath['shipping_charge_price']).visible?}
   $shipCost=page.find(:xpath, @xpath['shipping_charge_price']).text
   if($shipCost==@xpath['free_ship_charge'])
      @log.debug("Shipping cost without promo is ")
      @log.debug("#{$shipCost}")
      @log.debug("test case passed")
      @log.debug("Free shipping checked successfully")
   else
      @log.debug( "Test case failed")
      @log.debug("Free shipping has cost")
   end
end

#I click on back one step button
And /^I click on back one step$/ do
   wait_until{page.find(:xpath, @xpath['back_one_step']).visible?}
   page.find(:xpath, @xpath['back_one_step']).click
   @log.debug("back one step clicked")
end
#I enter a promo code 
Then /^I enter a promo code$/ do
   fill_in @xpath['promo_code'],:with=> @xpath['promo_code_value']
   @log.debug("Entered the promo code for discount")
end

#I verify if there is shopping cost in the bag     
And /^I verify if there is shipping cost$/ do
  wait_until{page.find(:xpath, @xpath['bag_estimated_total']).visible?}     
  $shipCost=page.find(:xpath, @xpath['bag_estimated_total']).text
  if($shipCost== @value['default_shipping_charge'].to_s)
    @log.debug("Shipping cost with promo is #{$shipCost}")
    @log.debug("test case passed")
    @log.debug("Verified shipping has cost")
  else
    @log.debug("Test case failed")
    @log.debug("Verified shipping did not have cost")
  end
end  
 
#I verify for the shipping cost in all pages   
And /^I verify if the cost is present$/ do
    wait_until{page.find(:xpath, @xpath['shipping_charge_price']).visible?}
    $shipCost=page.find(:xpath, @xpath['shipping_charge_price']).text
    if($shipCost== @value['default_shipping_charge'].to_s)
      @log.debug("Shipping cost with promo is $")
      @log.debug("#{$shipCost}")
      @log.debug("Test case passed")
      @log.debug("Verified shipping has cost")
    else
      @log.debug("Test case failed")
      @log.debug("Verified shipping did not have cost")
    end
end