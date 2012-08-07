#Script Name        :  newcheckoutpayment      
#Description        :  This class contains steps of payment page functionality.   
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
Then /^I should see the Payment page$/ do
  @expectedPaymentPageTitle = @config_data_file['checkout_payment_page_title']
  page_navigated = page.should have_content(@expectedPaymentPageTitle)
  @log.debug("Navigated to payment page")
end

And /^I select card type "([^"]*)"$/ do |cardtype|
  @cardtype=cardtype
  @billing_credit_card_type = @config_data_file['billing_credit_card_type']
  select(@cardtype, :from => @billing_credit_card_type)
end

And /^I enter card number "([^"]*)"$/ do |cardnumber|  
  @cardnumber=cardnumber
  @billing_card_number = @config_data_file['billing_card_number']
  fill_in @billing_card_number, :with => @cardnumber
end

And /^I select expiry month "([^"]*)"$/ do |expmonth|
  @expmonth=expmonth
  @billing_expiration_month = @config_data_file['billing_expiration_month']
  select(@expmonth, :from => @billing_expiration_month)
end

And /^I select expiry year "([^"]*)"$/ do |expyear|  
  @expyear=expyear
  @billing_expiration_year = @config_data_file['billing_expiration_year']
  select(@expyear, :from => @billing_expiration_year)
end

And /^I enter security code "([^"]*)"$/ do |securitycode|  
  @billing_security_code = @config_data_file['billing_security_code']
  @securitycode=securitycode
  fill_in @billing_security_code, :with => @securitycode
end

And /^I select same as my shipping address of billing address$/ do  
   @billing_sameasshippingaddress = @config_data_file['billing_sameasshippingaddress']
   check(@billing_sameasshippingaddress)  
end
And /^I enter contact email address "([^"]*)"$/ do |contactemailaddress|
  @contactemailaddress=contactemailaddress
  @billing_contact_emailaddress = @config_data_file['billing_contact_emailaddress']
  fill_in @billing_contact_emailaddress, :with => @contactemailaddress
end

And /^I enter contact phonenumber areacode "([^"]*)"$/ do |phonenumberarea|
  @phonenumberarea=phonenumberarea
  @billing_area_code= @config_data_file['billing_area_code']
  fill_in @billing_area_code, :with => @phonenumberarea
end

And /^I enter contact phonenumber exchangeNbr "([^"]*)"$/ do |phonenumberexchange|
  @phonenumberexchange=phonenumberexchange
  @billing_exchange_nbr = @config_data_file['billing_exchange_nbr']
  fill_in @billing_exchange_nbr, :with => phonenumberexchange
end

And /^I enter contact phonenumber subscriberNbr "([^"]*)"$/ do |phonenumbersubscriber|
  @phonenumbersubscriber=phonenumbersubscriber
  @billing_subscriber_nbr = @config_data_file['billing_subscriber_nbr']
  fill_in @billing_subscriber_nbr, :with => @phonenumbersubscriber
end

When /^I continue checkout on payment page$/ do
  @billing_continue_checkout_btn = @config_data_file['billing_continue_checkout_btn']
  wait_until_entity_exists("path",@billing_continue_checkout_btn , 30, "")  
  page.find(:xpath, "#{@billing_continue_checkout_btn}").click
end

Then /^I should see the Payment page with error message$/ do
 # page.wait_until do
  page.text.include? "errormessage"
#end
end

Then /^I should see EGC overlay$/ do
  @billing_egc_overlay_cancel = @config_data_file['billing_egc_overlay_cancel']
  if (page.find(:xpath, "#{@billing_egc_overlay_cancel}").visible?) then
    @log.debug("EGC overlay is displayed")
  else
    raise "EGC overlay is not displayed"
   end 
end

Then /^I am on payment page with error message$/ do
   @payment_page_url = @config_data_file['checkout_payment_page_url']
   page_navigated = page.should have_content(@payment_page_url) 
end

And /^credit card number should be masked except for last (\d+) digits$/ do |arg1|
   @billing_card_number_val = @config_data_file['billing_card_number_val']
   maskedCardNumber=page.find(:xpath, "#{@billing_card_number_val}").value.to_s
   pageMaskedCard = maskedCardNumber.match(/[*]+[0-9]+/).to_s
   if (maskedCardNumber.should==pageMaskedCard)
   @log.debug("Credit card is masked except for last four numbers")
   else
   maskedCardNumber.should_not==pageMaskedCard
   @log.debug("Credit card is Not masked except for last four numbers")
  end
end

Then /^expiration date fields and security code field should be disabled$/ do
   @billing_expiration_month = @config_data_file['billing_expiration_month']
   @billing_expiration_year = @config_data_file['billing_expiration_year']
   if (page.find(:xpath, "#{@billing_expiration_month}").visible?)
   raise "Expiration month is visible"
   else
   @log.debug("Expiration month is not visible")
  end
  if (page.find(:xpath, "#{@billing_expiration_year}").visible?)
    raise "Expiration year is visible"
  else 
    @log.debug("Expiration year is not visible")
   end
end

When /^I click on add card button on payment page$/ do
  @billing_addcard_btn = @config_data_file['billing_addcard_btn']
  wait_until_entity_exists("path","#{@billing_addcard_btn}" , 30, "")  
  page.find(:xpath, "#{@billing_addcard_btn}").click
end

Then /^I am on order review page$/ do
  loadchkconfig()
   @orderreview_page_title = @config_data_file['checkout_orderreview_page_title']
   page_navigated = page.has_content? @orderreview_page_title 
end

And /^I select create profile checkbox$/ do
  @billing_create_profile_checkbox = @config_data_file['billing_create_profile_checkbox']
  check(@billing_create_profile_checkbox)
end

And /^I enter profile email address "([^"]*)"$/ do |profileemailaddress|
  @createprofileemailaddress=profileemailaddress
  @billing_create_profile_emailaddress = @config_data_file['billing_create_profile_emailaddress']
  fill_in @billing_create_profile_emailaddress, :with => @createprofileemailaddress
end

And /^I enter profile confirm email address "([^"]*)"$/ do |profileconfirmemail|
  @createprofileconfirmemail=profileconfirmemail
  @billing_create_profile_confirmemailaddress = @config_data_file['billing_create_profile_confirmemailaddress']
  fill_in @billing_create_profile_confirmemailaddress, :with => @createprofileconfirmemail
end

And /^I enter profile password "([^"]*)"$/ do |profilepwd|
  @createprofilepwd=profilepwd
  @billing_create_profile_password= @config_data_file['billing_create_profile_password']
  fill_in @billing_create_profile_password, :with => @createprofilepwd
end

And /^I enter profile confirm password "([^"]*)"$/ do |profileconfirmpwd|
  @createprofileconfirmpwd=profileconfirmpwd
  @billing_create_profile_confirmpassword = @config_data_file['billing_create_profile_confirmpassword']
  fill_in @billing_create_profile_confirmpassword, :with => @createprofileconfirmpwd
end

And /^I select profile birthday month "([^"]*)"$/ do |birthmonth|
  @birthmonth=birthmonth
  @billing_create_profile_birthmonth = @config_data_file['billing_create_profile_birthmonth']
  select(@birthmonth, :from => @billing_create_profile_birthmonth)
end

And /^I select profile birthday date "([^"]*)"$/ do |birthdate|
  @birthdate=birthdate
  @billing_create_profile_birthday = @config_data_file['billing_create_profile_birthday']
  select(@birthdate, :from => @billing_create_profile_birthday)
end

And /^I select profile birthday year "([^"]*)"$/ do |birthyear|
  @birthyear=birthyear
  @billing_create_profile_birthyear = @config_data_file['billing_create_profile_birthyear']
  select(@birthyear, :from => @billing_create_profile_birthyear)
end

And /^I enter gift card number "([^"]*)"$/ do |egccardnumber|
  @egccardnumber=egccardnumber
  @billing_egc_cardnumber= @config_data_file['billing_egc_cardnumber']
  fill_in @billing_egc_cardnumber, :with => @egccardnumber
end

And /^I enter captcha security verification code "([^"]*)"$/ do |captcha|
  @captcha=captcha
  @billing_egc_captcha= @config_data_file['billing_egc_captcha']
  fill_in @billing_egc_captcha, :with => @captcha
end

When /^I click on add card$/ do
  @billing_egc_addcard = @config_data_file['billing_egc_addcard']
  wait_until_entity_exists("path","#{@billing_egc_addcard}" , 30, "")
  page.find(:xpath, "#{@billing_egc_addcard}").click
end

Then /^I should see the EGC overlay with error message$/ do
 
end

Then /^I should see empty captcha text field$/ do
 if(@billing_empty_egc_captcha.should == "")    
    @log.debug("Captcha text field is cleared")
  else
    @billing_empty_egc_captcha.should_not == ""
    @log.debug("Captcha text field is not cleared")
  end
end

When /^I click on new image$/ do
  @billing_egc_newcaptcha = @config_data_file['billing_egc_newcaptcha']
  wait_until_entity_exists("path","#{@billing_egc_newcaptcha}" , 30, "")
  page.find(:xpath, "#{@billing_egc_newcaptcha}").click
end

Then /^I should see new captch security verification code$/ do
  pending # express the regexp above with the code you wish you had
end

And /^I should see the payment page URL$/ do
  browser = Capybara.current_session
  curr_url = browser.current_url
  @payment_page_url = @config_data_file['checkout_payment_page_url']
  if (curr_url.index(@payment_page_url))
    @log.debug("Payment page URL is displayed as expected")
  else
    raise "Payment page URL is not displayed as expected"
  end
end

Then /^I should be again redirected to Payment page$/ do
  browser = Capybara.current_session
  curr_url = browser.current_url
  @payment_errorpage_url = @config_data_file['checkout_payment_errorpage_url']
  if (curr_url.index(@payment_errorpage_url))
   @log.debug("Redirected to payment page after error is displayed")
  else
   raise "Not redirected to payment page after error is displayed"
  end
end

And /^I should see empty security code field$/ do
  @billing_security_code_val = @config_data_file['billing_security_code_val']
  @billing_empty_security_code_value = page.find(:xpath, "#{@billing_security_code_val}").value  
  if(@billing_empty_security_code_value == "")
     @billing_empty_security_code_value.should == ""
     @log.debug("Security field is cleared")
   else
     @billing_empty_security_code_value.should_not == ""
     @log.debug("Security field is not cleared")
   end
end

And /^I should see card number text field in EGC overlay$/ do
  @billing_egc_cardnumber= @config_data_file['billing_egc_cardnumber']
   if (page.find(:xpath, @billing_egc_cardnumber).visible?) then
    @log.debug("Card number text field on EGC overlay is displayed")
   else
    raise "Card number text field on EGC overlay is not displayed"
   end 
end

And /^I should see captcha image in EGC overlay$/ do
  @billing_egc_captcha_image = @config_data_file['billing_egc_captcha_image']
   if (page.find(:xpath, @billing_egc_captcha_image).visible?) then
    @log.debug("Captcha image on EGC overlay is displayed")
   else
    raise "Captcha image on EGC overlay is not displayed"
   end 
end

And /^I should see new image button in EGC overlay$/ do
  @billing_egc_newcaptcha = @config_data_file['billing_egc_newcaptcha']
   if (page.find(:xpath, @billing_egc_newcaptcha).visible?) then
    @log.debug("New image button on EGC overlay is displayed")
   else
    raise "New image button on EGC overlay is not displayed"
   end 
end

And /^I should see text field to enter captcha in EGC overlay$/ do
   @billing_egc_captcha= @config_data_file['billing_egc_captcha']
   if (page.find(:xpath, @billing_egc_captcha).visible?) then
    @log.debug("Enter captcha text field on EGC overlay is displayed")
   else
    raise "Enter captcha text field on EGC overlay is not displayed"
   end 
end

And /^I should see submit button in EGC overlay$/ do
  @billing_egc_addcard = @config_data_file['billing_egc_addcard']
   if (page.find(:xpath, @billing_egc_addcard).visible?) then
    @log.debug("Submit button on EGC overlay is displayed")
   else
    raise "Submit button on EGC overlay is not displayed"
   end 
end

And /^I should see cancel button in EGC overlay$/ do
   @billing_egc_cancel = @config_data_file['billing_egc_cancel']
   if (page.find(:xpath, @billing_egc_cancel).visible?) then
    @log.debug("Cancel button on EGC overlay is displayed")
   else
    raise "Cancel button on EGC overlay is not displayed"
   end 
end

When /^I enter new payment information$/ do
  @billing_contact_emailaddress = @config_data_file['billing_contact_emailaddress']
  @email_address=@config_data_file['edit_billing_new_contact_emailaddress']
  fill_in @billing_contact_emailaddress, :with => @email_address
  @billing_contact_emailaddress_verify=@config_data_file['billing_contact_emailaddress_verify']
  fill_in @billing_contact_emailaddress_verify, :with => @email_address
end

Then /^I validate billing address same as shipping address$/ do
  @billing_first_name_val = @config_data_file['billing_first_name_val']
  @billing_last_name_val = @config_data_file['billing_last_name_val']
  @billing_address_1_val = @config_data_file['billing_address_1_val']
  @billing_city_val = @config_data_file['billing_city_val']
  @billing_state_val = @config_data_file['billing_state_val']
  @billing_zipcode_val = @config_data_file['billing_zipcode_val']
  #Verify shipping address and billing address same
  page.find(:xpath, "#{@billing_first_name_val}").value == @new_shipping_firstname
  page.find(:xpath, "#{@billing_last_name_val}").value == @new_shipping_lastname
  page.find(:xpath, "#{@billing_address_1_val}").value == @new_shipping_address1
  page.find(:xpath, "#{@billing_city_val}").value == @new_shipping_city
  page.find(:xpath, "#{@billing_state_val}").value == @new_shipping_state
  page.find(:xpath, "#{@billing_zipcode_val}").value.to_i == @new_shipping_zip_code
end

When /^I enter credit card details$/ do
  loadchkconfig()         
  @billing_credit_card_type = @config_data_file['billing_credit_card_type']
  @billing_card_number = @config_data_file['billing_card_number']
  @billing_expiration_month = @config_data_file['billing_expiration_month']
  @billing_expiration_year = @config_data_file['billing_expiration_year'] 
  @billing_security_code = @config_data_file['billing_security_code']
  @cardtype = @config_data_file['billing_new_card_type']
  @cardnumber = @config_data_file['billing_new_card_number']
  @securitycode = @config_data_file['billing_new_card_securitycode']
  @expmonth = @config_data_file['billing_new_card_month']
  @expyear = @config_data_file['billing_new_card_year']  
  
  select(@cardtype, :from => @billing_credit_card_type)
  fill_in @billing_card_number, :with => @cardnumber
  fill_in @billing_security_code, :with => @securitycode
  select(@expmonth, :from => @billing_expiration_month)
  select(@expyear.to_s, :from => @billing_expiration_year)
end

When /^I enter billing address$/ do
  #retrieving Value from xpaths.yml
  loadchkconfig()
  @firstname = @config_data_file['new_shipping_firstname']
  @lastname = @config_data_file['new_shipping_lastname']
  @addressline1 = @config_data_file['new_shipping_address1']
  @city = @config_data_file['new_shipping_city']
  @state = @config_data_file['new_shipping_state']
  @zipcode = @config_data_file['new_shipping_zip_code']
  @phonenumberarea = @config_data_file['new_shipping_area_code']
  @phonenumberexchangeNbr = @config_data_file['new_shipping_exchange_code']
  @phonenumbersubscriberNbr = @config_data_file['new_shipping_subscriber_code']
  @shipping_first_name = @config_data_file['shipping_first_name1']
  @shipping_last_name = @config_data_file['shipping_last_name1']
  @shipping_address_1 = @config_data_file['shipping_address_11']
  @shipping_address_2 = @config_data_file['shipping_address_22']
  @shipping_city = @config_data_file['shipping_city1']
  @shipping_state = @config_data_file['shipping_state1']
  @shipping_state_select = @config_data_file['shipping_state_select1']
  @shipping_zipcode = @config_data_file['shipping_zipcode1']
  @shipping_area_code = @config_data_file['shipping_area_code1']
  @shipping_exchange_nbr = @config_data_file['shipping_exchange_nbr1']
  @shipping_subscriber_nbr = @config_data_file['shipping_subscriber_nbr1']
  
  #Enter the Values in textboxes
  fill_in @shipping_first_name, :with => @firstname
  fill_in @shipping_last_name, :with => @lastname
  fill_in @shipping_address_1, :with => @addressline1
  fill_in @shipping_city, :with => @city
  select(@state, :from => @shipping_state_select)
  fill_in @shipping_zipcode, :with => @zipcode
  fill_in @shipping_area_code, :with => @phonenumberarea
  fill_in @shipping_exchange_nbr, :with => @phonenumberexchangeNbr
  fill_in @shipping_subscriber_nbr, :with => @phonenumbersubscriberNbr
  @billing_contact_emailaddress = @config_data_file['billing_contact_emailaddress']
  @email_address=@config_data_file['billing_new_contact_emailaddress']
  fill_in @billing_contact_emailaddress, :with => @email_address
  @billing_contact_emailaddress_verify=@config_data_file['billing_contact_emailaddress_verify']
  fill_in @billing_contact_emailaddress_verify, :with => @email_address
  @billing_area_code= @config_data_file['billing_area_code']
  fill_in @billing_area_code, :with => @billing_new_area_code
  @billing_exchange_nbr = @config_data_file['billing_exchange_nbr']
  fill_in @billing_exchange_nbr, :with => @billing_new_exchange_code
  @billing_subscriber_nbr = @config_data_file['billing_subscriber_nbr']
  fill_in @billing_subscriber_nbr, :with => @billing_new_subscriber_code
end