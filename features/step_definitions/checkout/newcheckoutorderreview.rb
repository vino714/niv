#Script Name        :  newcheckoutorderreview
#Description        :  This class contains steps of order review page functionality.
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
Then /^I should see the order review page$/ do
  @expectedOrderReviewPageTitle=@config_data_file['checkout_orderreview_page_title']
  page_navigated = page.should have_content(@expectedOrderReviewPageTitle)
  @log.debug("Navigated to order review page")
end

And /^I should see contact email address$/ do
  @order_review_contact_email = @config_data_file['order_review_contact_email']
  @log.debug("Contact email address entered on payment page: " + @contactemailaddress)
  wait_until_entity_exists("path", "#{@order_review_contact_email}" , 30, "")
  @order_review_contactemail = page.find(:xpath, "#{@order_review_contact_email}").text
  @log.debug("Contact email address on order review page: " + @order_review_contactemail)
  if (@order_review_contactemail.should == @contactemailaddress)
    @log.debug("Contact email address is displaying as expected on order review page")
  else
    @order_review_contactemail.should_not == @contactemailaddress
    @log.debug("Contact email address is not displaying as expected on order review page")
  end
end

Then /^I should see contact phone number$/ do
  @order_review_phone = @config_data_file['order_review_phone']
  @contactphonenumber = @contactphonenumberareacode + @contactphonenumberexchangeNbr + @contactphonenumbersubscriberNbr
  @log.debug("Contact phone number entered on payment page: " + @contactphonenumber)
  wait_until_entity_exists("path","#{@order_review_phone}" , 30, "")
  @order_review_phone = page.find(:xpath, "#{@order_review_phone}").text
  @log.debug("Contact phone on Order review page: " + @order_review_phone)
  if (@contactphonenumber.should == @order_review_phone)
    @log.debug("Contact phone number is displaying as expected on order review page")
  else
    @contactphonenumber.should_not == @order_review_phone
    @log.debug("Contact phone number is not displaying as expected on order review page")
  end
end

When /^I place order on review page$/ do
  @order_review_place_order_btn=@config_data_file['order_review_place_order_btn']
  wait_until_entity_exists("path","#{@order_review_place_order_btn}" , 30, "")
  page.find(:xpath, "#{@order_review_place_order_btn}").click
  @log.debug("Order placed successfully")
end

When /^I click the edit shipping address button$/ do
  @order_review_edit_shipping_details_btn=@config_data_file['order_review_edit_shipping_details_btn']
  wait_until_entity_exists("path","#{@order_review_edit_shipping_details_btn}" , 30, "")
  page.find(:xpath, "#{@order_review_edit_shipping_details_btn}").click
end

When /^I click the edit payment address button$/ do
  @order_review_edit_payment_details_btn=@config_data_file['order_review_edit_payment_details_btn']
  wait_until_entity_exists("path","#{@order_review_edit_payment_details_btn}" , 30, "")
  page.find(:xpath, "#{@order_review_edit_payment_details_btn}").click
end

And /^I should see the order review page URL$/ do
  browser = Capybara.current_session
  curr_url = browser.current_url
  @checkout_order_review_page_url=@config_data_file['checkout_order_review_page_url']
  if (curr_url.index(@checkout_order_review_page_url))
    @log.debug("Review page URL is displayed as expected")
  else
    raise "Review page URL is not displayed as expected"
  end
end

Then /^the shipping address should be correct on order review page$/ do
  @order_review_edit_shipping_details_info=@config_data_file['order_review_edit_shipping_details_info']
  @order_review_page_ship_address = page.find(:xpath, @order_review_edit_shipping_details_info).text.should == @firs
  @state_code=@state_data_file[@state]
  #Checking for First name Updation in review page
  if (@order_review_page_ship_address.include? @firstname)
      @log.debug("First Name is Updated")
  else
    raise "First Name is Not Updated"
  end
  #Checking for Last name Updation in review page
   if (@order_review_page_ship_address.include? @lastname)
      @log.debug("Last Name is Updated")
   else
    raise "Last Name is Not Updated"
  end
  #Checking for Address Updation in review page
  if (@order_review_page_ship_address.include? @addressline1)
     @log.debug("Shipping Address is Updated")
   else
    raise "Shipping Address is not Updated"
  end
  #Checking for City Updation in review page
  if (@order_review_page_ship_address.include? @city)
    @log.debug("City is Updated")
   else
    raise "City is not Updated"
  end
  #Checking for Zipcode Updation in review page
  if (@order_review_page_ship_address.include? @zipcode) 
   @log.debug("Zip code is Updated")
   else
    raise "Zip code is not Updated"
  end
  #Checking for Phonenumber Updation in review page
  if((@order_review_page_ship_address.include? @phonenumberarea) && (@order_review_page_ship_address.include? @phonenumberexchangeNbr) && (@order_review_page_ship_address.include?  @phonenumbersubscriberNbr))
  @log.debug("Phone Number is Updated")
   else
    raise "Phone Number is not Updated"
  end  
  #Checking for State Updation in review page
  if (@order_review_page_ship_address.include?  @state_code)
       @log.debug("State is updated")
   else
    raise "State is not updated"
  end
end

Then /^the billing address should be correct on order review page$/ do
  #retrieving Data from xpaths.yml
  @firstname = @config_data_file['new_shipping_firstname'].to_s
  @lastname = @config_data_file['new_shipping_lastname'].to_s
  @addressline1 = @config_data_file['new_shipping_address1'].to_s
  @city = @config_data_file['new_shipping_city'].to_s
  @state = @config_data_file['new_shipping_state'].to_s
  @zipcode = @config_data_file['new_shipping_zip_code'].to_s
  @phonenumberarea = @config_data_file['new_shipping_area_code'].to_s
  @phonenumberexchangeNbr = @config_data_file['new_shipping_exchange_code'].to_s
  @phonenumbersubscriberNbr = @config_data_file['new_shipping_subscriber_code'].to_s
  @order_review_payment_details_info=@config_data_file['order_review_payment_details_info']
  state_data_file = "config/CHKOUT/states.yml"
  @state_data_file=YAML::load(File.open(state_data_file))
  @state_code=@state_data_file[@state]
  @order_review_page_billing_address = page.find(:xpath, "#{@order_review_payment_details_info}").text
    #Checking for First name Updation in review page
    if (@order_review_page_billing_address.include? @firstname)
      @log.debug("First Name is Updated")
  else
    raise "First Name is Not Updated"
  end
  #Checking for Last name Updation in review page
   if (@order_review_page_billing_address.include? @lastname)
      @log.debug("Last Name is Updated")
   else
    raise "Last Name is Not Updated"
  end
  #Checking for Address Updation in review page
  if (@order_review_page_billing_address.include? @addressline1)
     @log.debug("Shipping Address is Updated")
   else
    raise "Shipping Address is not Updated"
  end
  #Checking for City Updation in review page
  if (@order_review_page_billing_address.include? @city)
    @log.debug("City is Updated")
   else
    raise "City is not Updated"
  end
  #Checking for Zipcode Updation in review page
  if (@order_review_page_billing_address.include? @zipcode) 
   @log.debug("Zip code is Updated")
   else
    raise "Zip code is not Updated"
  end
  #Checking for Phonenumber Updation in review page
  if((@order_review_page_billing_address.include? @phonenumberarea) && (@order_review_page_billing_address.include? @phonenumberexchangeNbr) && (@order_review_page_billing_address.include?  @phonenumbersubscriberNbr))
  @log.debug("Phone Number is Updated")
   else
    raise "Phone Number is not Updated"
  end  
  #Checking for State Updation in review page
  if (@order_review_page_billing_address.include?  @state_code)
       @log.debug("State is updated")
   else
    raise "State is not updated"
  end
end

And /^shipping address should be updated in order review page$/ do
  @review_shipping_info=@config_data_file['updated_shipping_address']
  @state = @config_data_file['new_shipping_state'].to_s
  #Load States.yml
  state_data_file = "config/CHKOUT/states.yml"
  @state_data_file=YAML::load(File.open(state_data_file))
  #Retrieving State Code from states.yml 
  @state_code=@state_data_file[@state]
  @updated_shipping_address=page.find(:xpath,@review_shipping_info).text
  #Checking for First name Updation in review page
  if (@updated_shipping_address.include? @edit_shipping_firstname.to_s)
      @log.debug("First Name is Updated")
  else
    raise "First Name is Not Updated"
  end
  #Checking for Last name Updation in review page
  if (@updated_shipping_address.include? @edit_shipping_lastname.to_s)
    @log.debug("Last Name is Updated")
   else
    raise "Last Name is Not Updated"
  end
  #Checking for Address Updation in review page
  if (@updated_shipping_address.include? @edit_shipping_address1.to_s)
    @log.debug("Shipping Address is Updated")
   else
    raise "Shipping Address is not Updated"
  end
  #Checking for City Updation in review page
  if (@updated_shipping_address.include? @edit_shipping_city.to_s)
    @log.debug("City is Updated")
   else
    raise "City is not Updated"
  end
  #Checking for Zipcode Updation in review page
  if (@updated_shipping_address.include? @edit_shipping_zip_code.to_s)
     @log.debug("Zip code is Updated")
   else
    raise "Zip code is not Updated"
  end
  #Checking for Phonenumber Updation in review page
  if((@updated_shipping_address.include? @edit_shipping_area_code.to_s) && (@updated_shipping_address.include? @edit_shipping_exchange_code.to_s) && (@updated_shipping_address.include? @edit_shipping_subscriber_code.to_s))
     @log.debug("Phone Number is Updated")
   else
    raise "Phone Number is not Updated"
  end
  #Checking for State Updation in review page
  if(@updated_shipping_address.include? @state_code.to_s)
    @log.debug("State is updated")
   else
    raise "State is not updated"
  end
end

And /^I see updated payment information$/ do
  @order_review_edit_payment_details_info=@config_data_file['order_review_edit_payment_details_info']
  @order_review_page_billing_address = page.find(:xpath, "#{@order_review_edit_payment_details_info}").text.to_s
  if (@order_review_page_billing_address.include? (@edit_billing_new_contact_emailaddress.to_s))
    @log.debug("Payment Information is updated in order review page")
   else
    raise "Payment information is Not updated"
  end
end

Given /^I am on order review page of new checkout$/ do
  steps %Q{
          Given I am on the Macy's home page
          Then I navigate to product detail page with common product id "<prodid>"
           |prodid|
           |1310|
          When I add items on bag
          Then I am on the your shopping bag page
          When I continue checkout on your shopping bag page
          Then I am on checkout signin page
          When I continue as a guest user
          Then I should see the Shipping page
          When I enter shipping details
          When I continue checkout on shipping page
          Then I should see the Payment page
          When I enter credit card details
            And I enter billing address
          When I continue checkout on payment page
          Then I should see the order review page
      }
end

Then /^I validate the fields_and_buttons on "([^"]*)" page$/ do |pagename|
#Check all fields are present in review page
@order_review_place_order_btn=@config_data_file['order_review_place_order_btn']
@order_review_edit_shipping_details_btn=@config_data_file['order_review_edit_shipping_details_btn']
@order_review_edit_payment_details_btn=@config_data_file['order_review_edit_payment_details_btn']
page.find(:xpath, @order_review_place_order_btn) != nil
page.find(:xpath, @order_review_edit_shipping_details_btn) != nil
page.find(:xpath, @order_review_edit_payment_details_btn) != nil
end

And /^I validate the fields_and_buttons on ordereview page$/ do |pagename|
#page.find(:xpath, "#{@order_review_edit_shipping_details_btn}") != nil
#page.find(:xpath, "#{@order_review_contact_email}") != nil
page.find(:xpath, @order_review_place_order_btn) != nil
page.find(:xpath, @order_review_edit_shipping_details_btn) != nil
page.find(:xpath, @order_review_place_order) != nil
#page.find(:xpath, "//a/span").text.should == 'back one step'
end
