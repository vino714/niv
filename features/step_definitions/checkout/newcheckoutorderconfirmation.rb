#Script Name        :  newcheckoutorderconfirmation
#Description        :  This class contains steps of order confirmation page functionality.
#Author             :  NISUM Technologies
#Reviewer           :  Ravi Gummala
#Creation Date      :  05/18/2012
#Pre-conditions     :  Base environment, access to the Software Request System.
#Post-conditions:   :  Regression of the Software Request System based on functionality.
#Data Files         :  None at this level.
#******************************************************************************************************
# Revision History
#******************************************************************************************************
#Date               :
#Revised By         :
#******************************************************************************************************
Then /^I should see the order confirmation page$/ do
  @checkout_orderconfirmation_page_title = @config_data_file['checkout_orderconfirmation_page_title']
  page_navigated = page.should have_content(@checkout_orderconfirmation_page_title)
  @log.debug("Navigated to order confirmation page")
end

When /^I navigate to shopping bag page$/ do
  @header_macys_logo = @config_data_file['header_macys_logo']
  @shoppingbag_icon = @config_data_file['shoppingbag_icon']
  wait_until_entity_exists("path","#{@header_macys_logo}" , 30, "")
  page.find(:xpath, @header_macys_logo).click
  wait_until_entity_exists("path","#{@shoppingbag_icon}" , 30, "")
  page.find(:xpath, @shoppingbag_icon).click  
end

Then /^I should see profile email address$/ do
  @order_confirmation_profile_email = @config_data_file['order_confirmation_profile_email']
  @log.debug("Profile email address entered on payment page: " + @billing_create_profile_emailaddress)
  wait_until_entity_exists("path","#{@order_confirmation_profile_email}" , 30, "")
  @orderconfrimationprofileemail = page.find(:xpath, "#{@order_confirmation_profile_email}").text  
  @log.debug("Profile email address on order confirmation page: " + @orderconfrimationprofileemail)
  if (@billing_create_profile_emailaddress == @orderconfrimationprofileemail)
    @orderconfrimationprofileemail.should==@billing_create_profile_emailaddress 
    @log.debug("Profile email address is displaying as expected on order confirmation page")
  else
    @orderconfrimationprofileemail.should_not==@billing_create_profile_emailaddress 
    @log.debug("Profile email address is not displaying as expected on order confirmation page")
  end
end

Then /^I should see shipping address details$/ do
  @order_confirmation_profile_shipping_address = @config_data_file['order_confirmation_profile_shipping_address']
  @previousenteredshippingaddress = @firstname + " " + @lastname + "\n" + @addressline1 + "\n" + @addressline2 + "\n" + @city + ", " + @statevalue + " " + @zipcode
  @log.debug("Shipping address entered on shipping page: " + @previousenteredshippingaddress)
  wait_until_entity_exists("path","#{@order_confirmation_profile_shipping_address}" , 30, "")
  @orderconfrimationprofileshippingaddress = page.find(:xpath, "#{@order_confirmation_profile_shipping_address}").text
  @log.debug("Shipping address on Order confirmation page: " + @orderconfrimationprofileshippingaddress)
  if (@previousenteredshippingaddress == @orderconfrimationprofileshippingaddress)
    @orderconfrimationprofileshippingaddress.should==@previousenteredshippingaddress 
    @log.debug("Shipping address is displaying as expected on order confirmation page")
  else
    @orderconfrimationprofileshippingaddress.should_not==@previousenteredshippingaddress 
    @log.debug("Shipping address is not displaying as expected on order confirmation page")
  end
end

Then /^I should see the order confirmation page URL$/ do
  browser = Capybara.current_session
  curr_url = browser.current_url
  @checkout_order_confirm_page_url = @config_data_file['checkout_order_confirm_page_url']
  if (curr_url.index(@checkout_order_confirm_page_url))
    @log.debug("Confirmation page URL is displayed as expected")
  else
    raise "Confirmation page URL is not displayed as expected"
  end
end

And /^I should see the order number$/ do
  @order_number = @config_data_file['order_number']
  wait_until_entity_exists("path","#{@order_number}" , 30, "")
  get_order_number = page.find(:xpath,"#{@order_number}").text
  if(get_order_number!="")
    get_order_number.should!=""
    @log.debug("Order number is displayed on order confirmation page")
  else
    get_order_number.should_not!=""
    @log.debug("Order number is NOT displayed in order confirmation page")
  end
  @log.debug("Order Number is :" + "#{get_order_number}")
end

And /^I should see the order total$/ do
  @order_total = @config_data_file['order_total']
  wait_until_entity_exists("path","#{@order_total}" , 30, "")
   get_order_total = page.find(:xpath,"#{@order_total}").text
  if(get_order_total!="")
    get_order_total.should!=""
    @log.debug("Order total is displayed on order confirmation page")
  else
    get_order_total.should_not!=""
    @log.debug("Order total is NOT displayed in order confirmation page")
  end
  @log.debug("Order Total is :"+ "#{get_order_total}")
end