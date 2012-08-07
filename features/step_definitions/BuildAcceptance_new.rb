# verification of shopping bag
Then /^I should verify the "([^"]*)" number of product is in shopping bag$/ do |quantity|
  wait_until{page.find(:xpath, @xpath['shopping_bag_content']).visible?}
  if(page.has_xpath?@xpath['shopping_bag_item_container'])
    pdtQuantity = page.find(:xpath, @xpath['shopping_bag_item_quantity']).value
    if pdtQuantity.should == quantity.to_s
       @log.debug("Product added")
    end  
  else
    @log.debug("No Product not added")
  end
end

# Selection of submenu randomly
And /^I select a random submenu$/ do
if(page.has_xpath?@xpath['submenus'])
  $subMenuText = page.all(:xpath, @xpath['submenus']).sample.text
  click_link "#{$subMenuText}"
else
  steps %Q{
     And I select a random submenu
  }  
end
end 

# verification for the navigation of submenu
And /^I verify the submenu$/ do
  if(page.has_xpath?@xpath['submenu_container'])
   if page.has_content?"#{$subMenuText}"
      @log.debug("Navigated correctly to the subcategory #{$subMenuText}")
   end
  else
    steps %Q{  
      Then I select a menu randomly
      And I select a random submenu
      And I verify the submenu
    }
 end
end 

#Verification of Facets
Then /^I select the facet and verify it$/ do
if page.has_css?@xpath['facets_content']
    count = page.all(:css, @xpath['facets_content'], :visible => true).count
    count = count.to_i
    for i in 1..(count/2)
      wait_until{page.find(:xpath, @xpath['facets']).visible?}
      text = page.all(:css, @xpath['facets_link'], :visible => true).sample.text
      page.all(:css, @xpath['facets_link'], :visible => true, :text => "#{text}").first.click
      wait_until{page.find(:xpath, @xpath['facet_showall_container']).visible?}
      if (page.has_css?("li", :id => "#{text}", :visible => true))
        @log.debug("Facet Verified")
      currentCat = page.find(:xpath, @xpath['facet_currentCategory']).text
         if currentCat.should == text
          @log.debug("Facet in the current category")
         page.all(:css, @xpath['facets_showall']).first.click
       end
    end
    end
  else
    steps %Q{  
      Then I select a menu randomly
      And I select a random submenu
      And I verify the submenu
      Then I select the facet and verify it
    }
  end
end

#1366
When /^I open the given url for verifying the product$/ do
  url = @xpath['link']
  visit("#{url}")
  puts "Opened the first given URL"
end

Then /^I should be able to verify the product type$/ do
 #Master product verification
  if (page.has_xpath?@xpath['xpath_check_masterproduct'])
     page.find(:xpath, @xpath['xpath_check_masterproduct']).click
     puts "The selected product is a Master Product!!!!!"
     wait_until{page.find(:xpath, @xpath['xpath_master_product'])}.visible?
     page.all(:xpath, @xpath['xpath_master_product']).sample.click
     puts "Clicked one of the child products of the given master product successfully!!!!"
     
     #Master Product Full detail link verification
     if (page.has_xpath?@xpath['xpath_master_product_fulldetail'])
      puts "Clicked Master Product Full detail link verification"
      puts "User could view the Full details of the selected child product successfully!!!!"
     end
   else
     # Member Product selection
     puts "The selected product is not a master product and is a member product!!!!"
  end      
end


When /^I open another given url for verifying the product$/ do
  url1 = @xpath['link_member']
  visit("#{url1}")
  puts "Opened the second given URL"
end

And /^I visit to customer service page$/ do
@customer_service_path=@xpath['customer_service_path']
  wait_until{page.find(:xpath, @customer_service_path).visible?}
  page.find(:xpath, @customer_service_path).click
end

Then /^I verify the URL$/ do
@customer_service_page_url_production= @xpath['customer_service_page_url_production']
@customer_service_page_url_qa=@xpath['customer_service_page_url_qa']
  @env_current = get_env()
  browser = Capybara.current_session
  curr_url = browser.current_url
  case @env_current
  when '/PRODUCTION' 
    @customer_service_page_url=  @customer_service_page_url_production
  else
    @customer_service_page_url = @customer_service_page_url_qa
  end
  if (curr_url.index(@customer_service_page_url))
    @log.debug("Customer Service page URL is displayed as expected")
  else
    raise "Customer Service page URL is not displayed as expected"
  end
end
 
And /^I get all top level category into a list$/ do
  require 'java'
  java_import 'java.util.ArrayList'
  @main_menu_xpath=@xpath['main_menu_xpath']
  if (page.has_xpath? @main_menu_xpath)
    $arrlist=ArrayList.new
    i=1
    page.all(:xpath, "//*[@id='globalNav']/ul/li[#{i}]/a/img").each do |node|
     size_class = node[:alt]
     $arrlist.add "#{size_class}"
     i=i+1
    end
  else
    $arrlist1=ArrayList.new
    i=1
    page.all(:xpath, "//*[@id='globalNav']/ul/li[#{i}]/a/img").each do |node|
     size_class = node[:alt]
     $arrlist1.add "#{size_class}"
     i=i+1
    end
  end  
end

Then /^I click on wedding registry link$/ do
  @wedding_registry_xpath=@xpath['wedding_registry_xpath']
  page.find(:xpath, @wedding_registry_xpath).click  
end

And /^I compare both lists$/ do
  if ($arrlist.equals($arrlist1))
    @log.debug("The content does not alter")
  else
    @log.debug("The content is altered to registers")
  end
end

Then /^I verify display$/ do
@main_menu_ul_xpath=@xpath['main_menu_ul_xpath']
@container_xpath=@xpath['container_xpath']
  page.all(:xpath, @main_menu_ul_xpath).sample.click
  if (page.has_xpath? @container_xpath)
    @log.debug("There is a display page")
  else
    @log.debug("There is no display page") 
  end
end

#Verify Registrant and shipment details..
And /^I verify the Registrant and shipment details$/ do
wait_until{page.find(:xpath,@xpath['xpath_co_Registry']).visible?}
if (page.has_xpath?@xpath['xpath_co_Registry'])
    page.find(:xpath,@xpath['xpath_co_Registry']).click
    @log.debug("\n Clicked the Registrant Address....!!!") 
  else
    @log.debug("\n Could not able to click Registrant Address !!!")
  end
end  


Then /^I verify the MCOM site$/ do
  url = @navigation_file['url']
  current_url.should == "#{url}"+"/"
  if(page.has_no_content?(" Oops! We're experiencing a technical problem. "))
        if (page.has_xpath? @xpath['Global_logo'])
            @log.debug("The website is available")
        else
            @log.debug("The website is not available")
        end 
  else
      @log.debug("The website is not available")
  end 
end


When /^I create a profile$/ do
  page.find(:xpath, @xpath['create_profile_btn']).click
end

When /^I enter profile details$/ do
  fill_in @xpath['create_profile_fname'], :with => @value['First_name']
  fill_in @xpath['create_profile_lname'], :with => @value['Last_name']
  fill_in @xpath['create_profile_address'], :with => @value['Address']
  fill_in @xpath['create_profile_city'], :with => @value['city'] 
  select(@value['state'], :from => @xpath['create_profile_state'])
  fill_in @xpath['create_profile_zipcode'], :with => @value['zipcode'] 
  timeNow = Time.now
  timeNow = timeNow.to_i
  timeNow = (timeNow/2).to_s
  #generate a mail id with timestamp attached to make it unique every time automation runs 
  $email = 'testuser'+timeNow+'@gmail.com'
  fill_in @xpath['create_profile_email'], :with => $email 
  fill_in @xpath['create_profile_verify'], :with => $email
  fill_in @xpath['create_profile_password'], :with => @value['password'] 
  fill_in @xpath['create_profile_verify_password'], :with => @value['verify_password']
  select(@value['security_qus'], :from => @xpath['create_profile_secure_qus'])
  fill_in @xpath['create_profile_secure_ans'], :with => @value['security_ans']
  select(@value['dob_month'], :from => @xpath['create_profile_month'])
  select(@value['dob_day'].to_s, :from => @xpath['create_profile_day'])
  select(@value['dob_year'].to_s, :from => @xpath['create_profile_year'])
  select(@value['sex'], :from => @xpath['create_profile_sex'])
  page.find(:xpath,@xpath['create_profile_page_btn']).click
end

Then /^I click "([^"]*)" link$/ do |arg1|
  click_link("#{arg1}")
end

And /^I enter credit card information$/ do
  select(@value['ccard_type'], :from => @xpath['wallet_ccard'])
  fill_in @xpath['wallet_cnumber'], :with => @value['ccard_number']
  select(@value['ccard_month'], :from => @xpath['wallet_month'])
  select(@value['ccard_year'].to_s, :from => @xpath['wallet_year'])
  fill_in @xpath['wallet_fname'], :with => @value['First_name']
  fill_in @xpath['wallet_lname'], :with => @value['Last_name']
  fill_in @xpath['wallet_address'], :with => @value['Address']
  fill_in @xpath['wallet_city'], :with => @value['city'] 
  select(@value['state'], :from => @xpath['wallet_state'])
  fill_in @xpath['wallet_zipcode'], :with => @value['zipcode'] 
  fill_in @xpath['wallet_area'], :with => @value['phone_area']
  fill_in @xpath['wallet_exchange'], :with => @value['phone_exchange']
  fill_in @xpath['wallet_sub'], :with => @value['phone_sub']
  fill_in @xpath['wallet_email'], :with => $email 
  fill_in @xpath['wallet_verify'], :with => $email
  page.find(:xpath, @xpath['wallet_save_btn']).click
end

And /^I enter add address$/ do
  fill_in @xpath['address_fname'], :with => @value['First_name']
  fill_in @xpath['address_lname'], :with => @value['Last_name']
  fill_in @xpath['address_address'], :with => @value['Address']
  fill_in @xpath['address_city'], :with => @value['city'] 
  select(@value['state'], :from => @xpath['address_state'])
  fill_in @xpath['address_zipcode'], :with => @value['zipcode'] 
  fill_in @xpath['address_area'], :with => @value['phone_area']
  fill_in @xpath['address_exchange'], :with => @value['phone_exchange']
  fill_in @xpath['address_sub'], :with => @value['phone_sub']
  page.find(:xpath, @xpath['address_add_btn']).click
end

And /^I click express checkout button$/ do
  page.find(:xpath, @xpath['express_checkout_btn']).click
end

And /^I enter security code$/ do
  fill_in @xpath['ccard_code_number'], :with => @value['seucrity_code']
end

And /^I click place order$/ do
  page.find(:xpath,@xpath['place_order_btn']).click  
end

Then /^I see order number$/ do
  if (page.has_xpath? @xpath['order_number'])
    @log.debug("Order Number is Generated")
  else
    @log.debug("Order Number is Not Generated")
  end  
end

And /^I click on Update in Registry Manager page$/ do
wait_until { page.find(:xpath, @xpath['btn_Update']).visible? }
  if (page.has_xpath?(@xpath['btn_Update']))
    page.find(:xpath, @xpath['btn_Update']).click
    @log.debug("Clicked the Update Wedding Registry link.")
  else
    @log.debug("Could not able to click Update Wedding Registry Link....")
  end
end  

And /^I click Edit Account link in BVR page$/ do
wait_until { page.find(:xpath, @xpath['link_editAcc']).visible? }
  if (page.has_xpath?(@xpath['link_editAcc']))
    page.find(:xpath, @xpath['link_editAcc']).click
    @log.debug("Clicked the edit Account link in BVR page...")
  else
    @log.debug("Could not able to click edit Account Link in BVR page....")
  end
end

And /^I update the Registrant information$/ do
     #verify the update page..  
     if (page.has_content?(@xpath['page_update']))
        @log.debug("Now Are you in Update Registry page...")
     else
         @log.debug("Navigated to wrong page instead of Update Registry page....")
     end  
     #update registrant's lastname...
     if (page.has_xpath?(@xpath['lastName1']))
       @oldln=page.find(:xpath, @xpath['lastName1']).value
       @log.debug("old lastname: #{@oldln}")
       if(@oldln)
         fill_in @xpath['lastName'], :with => @value['newlastName']
         @log.debug("Registrant's lastName updated...")        
       end 
     end 
     #update registrant's Address...
     if (page.has_xpath?(@xpath['address1']))
       @oldAdd=page.find(:xpath, @xpath['address1']).value
       @log.debug("old address: #{@oldAdd}")
       if(@oldAdd)
        fill_in @xpath['address'], :with => @value['newAddress']
        @log.debug("Registrant's Address updated...")      
       end 
     end 
     #click on Update button...
     if (page.has_xpath?(@xpath['update_btn']))
           page.find(:xpath, @xpath['update_btn']).click
           @log.debug("Registrant information updated...!")           
     else
           @log.debug("Some problem while updation...!")
     end
     #back to view registry button...
     if (page.has_xpath?(@xpath['btn_view_Reg']))
      page.find(:xpath, @xpath['btn_view_Reg']).click
     else
       @log.debug("View Registry button is not clicked...")
     end
     
end

Then /^I verify the updated information$/ do
  if (page.has_xpath?(@xpath['lastName1']))
       @newln=page.find(:xpath, @xpath['lastName1']).value
       @log.debug("new lastname: #{@newln}")       
       if(@newln.should==@oldln)
       @log.debug("Registrant lastName is updated successfully...!")
       end 
   end
   if (page.has_xpath?(@xpath['address1']))
       @newAdd=page.find(:xpath, @xpath['address1']).value
       @log.debug("new address: #{@newAdd}") 
       if(@newAdd.should==@oldAdd)
       @log.debug("Registrant address is updated Successfully....!")
       end 
   end 
end   

Then /^I click on SignOut button$/ do
  if(page.has_content? @xpath['sign_out'])
      click_link @xpath['sign_out'] 
      @log.debug("Clicked on the Singn Out link successfully")
    else
       @log.debug("Could not able to click the sign out link")
    end  
end   

And /^Give vaild new Username and Password details$/ do
  #Email text box verification and enter the value
  wait_until { page.find(:xpath,@xpath['email_id']).visible? }
  if (page.has_xpath?(@xpath['email_id']))
    fill_in @xpath['signin_email'], :with => $email
    @log.debug("Entered the Email is successfully")
  else
     @log.debug("Email text box in not loaded successfully")
  end
end 

And /^I enter user Create user details and Credit Card details for a new user$/ do
  
  fill_in @xpath['create_profile_fname'], :with => @value['First_name_CC']
  fill_in @xpath['create_profile_lname'], :with => @value['Last_name_CC']
  fill_in @xpath['create_profile_address'], :with => @value['Address']
  fill_in @xpath['create_profile_city'], :with => @value['city'] 
  select(@value['state'], :from => @xpath['create_profile_state'])
  fill_in @xpath['create_profile_zipcode'], :with => @value['zipcode'] 
  timeNow = Time.now
  timeNow = timeNow.to_i
  timeNow = (timeNow/2).to_s
  #generate a mail id with timestamp attached to make it unique every time automation runs 
  $email = 'testuser'+timeNow+'@gmail.com'
  fill_in @xpath['create_profile_email'], :with => $email 
  fill_in @xpath['create_profile_verify'], :with => $email
  fill_in @xpath['create_profile_password'], :with => @value['password'] 
  fill_in @xpath['create_profile_verify_password'], :with => @value['verify_password']
  select(@value['security_qus'], :from => @xpath['create_profile_secure_qus'])
  fill_in @xpath['create_profile_secure_ans'], :with => @value['security_ans']
  select(@value['dob_month'], :from => @xpath['create_profile_month'])
  select(@value['dob_day'].to_s, :from => @xpath['create_profile_day'])
  select(@value['dob_year'].to_s, :from => @xpath['create_profile_year'])
  select(@value['sex'], :from => @xpath['create_profile_sex'])
 
  fill_in @xpath['Macys_Ac_Number'], :with => @value['CC_No']
  fill_in @xpath['SSN Number'], :with => @value['Ssn_No']
  
  page.find(:xpath,@xpath['create_profile_page_btn']).click
end

Then /^I verify the credit card details has been entered correctly$/ do
  wait_until{ page.find(:xpath, @xpath['Macys_credit_card_xpath']).visible? }
  @CC_No_txt =page.find(:xpath, @xpath['Macys_credit_card_xpath']).text
  @CC_No_int =@CC_No_txt.to_i
  if(@CC_No_int == @value['CC_No'])
    @log.debug("The credit card detail entered is correct")    
  else if ((page.find(:xpath, @xpath['general_error'])).visible?)
    @log.debug("The card is either invalid or deactivated")    
  end
  end
end

Then /^I verify the bread crumbs$/ do
if page.has_css?@xpath['facets_content']
    count_facets = page.all(:css, @xpath['facets_content'], :visible => true).count
    count_facets = count_facets.to_i
    for i in 1..(count_facets/2)
      wait_until{page.find(:xpath, @xpath['facets']).visible?}
      $text = page.all(:css, @xpath['facets_link'], :visible => true).sample.text
      @log.debug("item selected #{$text}")
      page.all(:css, @xpath['facets_link'], :visible => true, :text => "#{$text}").first.click
      wait_until{page.find(:xpath, @xpath['facet_showall_container']).visible?}
      if (page.has_css?(@xpath['facets_breadCrums'], :id => "#{$text}", :visible => true))
        @log.debug("Bread Crumbs verified correctly")
        $itemCount = page.find(:css, @xpath['facets_items']).text
        @log.debug("the Number of items")
        @log.debug("#{$itemCount}")
        page.all(:css, @xpath['facets_showall']).first.click
      end
    end
  else
    steps %Q{
      Then I select a menu randomly
      And I select a random submenu
      And I verify the submenu
      Then I verify the bread crumbs
      }
  end
end

