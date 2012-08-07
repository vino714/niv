#visiting macys.com
Given /^I go for the MCOM site$/ do
  Capybara.run_server = false
  config_file = "config/#{ENV['ENVIRONMENT']}/navigation.yml"

  #Loaded file will be available throughout the execution of a scenario
  @navigation_file = YAML::load(File.open(config_file))

  #Fetching URL's from xpath file
  url = @navigation_file['url']

  #  Load Xpath File
  xpath_ids_file = "config/registry/xpaths.yml"
  @xpath= YAML::load(File.open(xpath_ids_file))
  
  #Value file  
  value_ids_file = "config/registry/values.yml" 
  @value= YAML::load(File.open(value_ids_file))
  
  Selenium::WebDriver::Firefox.path = "C:/Program Files/Mozilla Firefox/firefox.exe"
  Capybara.default_driver = :selenium
  
  # clear cookies
  browser = Capybara.current_session.driver.browser
  browser.manage.delete_all_cookies
  visit("#{url}") 
end

When /^I click on SignIn$/ do
    if(page.has_content? @xpath['signin_link'])
      click_link @xpath['signin_link']      
      @log.debug("Clicked on the Singn In link successfully")
    else
       @log.debug("Could not able to click the sign in link")
    end    
end


Then /^Navigate to "([^']*)" page$/ do |pageContent|
  if (page.has_content? pageContent )
    @log.debug("Successfully Navigated to the #{pageContent} Page")
  else
    @log.debug("Could not able to Navigate the #{pageContent} Page") 
  end   
end

And /^I give vaild credentials "([^']*)" and "([^']*)"$/ do |userName, password|
  #Email text box verification and enter the value
  wait_until { page.find(:xpath,@xpath['xemail']).visible? }
  if (page.has_xpath?(@xpath['xemail']))
    fill_in @xpath['txt_email'], :with => @value["#{userName}"]
    @log.debug("Entered the Email is successfully")
  else
     @log.debug("Email text box in not loaded successfully")
  end
  
  #Password text box verification and enter the value
  wait_until { page.find(:xpath, @xpath['xpassword']).visible? }
  if (page.has_xpath?( @xpath['xpassword']))
    fill_in @xpath['txt_password'], :with => @value["#{password}"]
    @log.debug("Entered Password is Successfully")
  else
     @log.debug("Password text box in not loaded successfully")
  end
  
  #Sign In button element verification and clicked on it
  wait_until { page.find(:xpath, @xpath['signin_button']).visible? }
  if (page.has_xpath?(@xpath['signin_button']))
    page.find(:xpath,@xpath['signin_button']).click
    @log.debug("Clicked the Sign In button element Successfully")
  else
    @log.debug("Could not able to click the Sign In button element")
  end  
end

#Wedding registry menu item verification and click on it
And /^Navigate to Macy's Wedding Registry Page/ do
wait_until { page.find(:xpath, @xpath['wedding_registry_id']).visible? }
  if (page.has_xpath?(@xpath['wedding_registry_id']))
    page.find(:xpath, @xpath['wedding_registry_id']).click
  else
    @log.debug("\n Could not able to click Wedding Registry Link....")
  end
end

When /^Search for an existing couple's registry as "([^']*)" and "([^']*)" who has selected the go green option$/ do |firstName, lastName|
  @firstName=@value["#{firstName}"]
  @lastName=@value["#{lastName}"]   
  #First Name of find a couple's registry text box
  wait_until { page.find(:xpath, @xpath['txt_first_name']).visible? }
  if (page.has_xpath?(@xpath['txt_first_name']))
    fill_in @xpath['txt_f_name'], :with => @firstName
    @log.debug("Successfully Entered First Name for Serach") 
  else
    @log.debug("First Name text box in not loaded successfully")
  end
  
  #Last Name of find a couple's registry text box
  wait_until { page.find(:xpath, @xpath['txt_last_name']).visible? }
  if (page.has_xpath?(@xpath['txt_last_name']))
    fill_in @xpath['txt_l_name'], :with => @lastName
    @log.debug("Successfully Entered the Last Name for Search")
  else
    @log.debug("Last Name text box in not loaded successfully")
  end
  
  #Find button element verification and clicking on it
  wait_until { page.find(:xpath, @xpath['btn_find_element']).visible? }
  if (page.has_xpath?(@xpath['btn_find_element']))
    page.find(:xpath, @xpath['btn_find_element']).click
    @log.debug("Clicked the Search button element")
  else
    @log.debug("Could not able to click the search button element")
  end  
end

Then /^Verify that successfully locate couple in Find Results$/ do
  #To verify registry user details
  @regUserName=@firstName+@lastName
  
  #To count no.of searched registry couples user availability
  regItemRowCounter = page.all(:css, @xpath['css_reg_Item_Row_Counter']).length
  
  #To count no.of searched registry couples user column availability
  regItemDataCounter = page.all(:css, @xpath['csspath_reg_Item_Data_Counter']).length
  i=1
  while(i<=regItemRowCounter)
    j=1
    while(j<=regItemDataCounter)
      @regItemData=page.find(:xpath, "//*[@id='resultsTable']/tbody[@class='tbmark']/tr[#{i}]/td[#{j}]").text
      if((@regItemData.delete(" ").downcase).should==@regUserName.delete("").downcase)
        @log.debug("Successfully Verified the searched couple's result: " +@regItemData)
        click_link page.find(:xpath, "//*[@id='resultsTable']/tbody[@class='tbmark']/tr[#{i}]/td[#{j+4}]").text
        break
      else
        j=j+1
      end       
    end
    i=i+1
  end  
end

And /^I click on view registry link$/ do
  @pageContent=@regItemData
  if (page.has_content? @pageContent)
    @log.debug("Successfully Navigated to View #{@pageContent} Registrant Page")
  else
    @log.debug("Not Navigated to View #{@pageContent} Registrant Page") 
  end  
end

When /^From GVR of the registry, add "([^']*)" items from registry to bag$/ do |number_of_item|
  @productNames = Array.new
  i=0
  j=1
  numberofitem=(@value["#{number_of_item}"]).to_i
  while(i<numberofitem)
     while(page.has_xpath?("//table[@class='registryTable']/tbody/tr[#{j}]"))
      if(page.has_xpath?("//table[@class='registryTable']/tbody/tr[#{j}]/td[7]"))
          page.find(:xpath, "//table[@class='registryTable']/tbody/tr[#{j}]/td[7]/div/select/option[2]").click
          @productNames[i] =page.find(:xpath, "//table[@class='registryTable']/tbody/tr[#{j}]/td[2]/div/ul/li/a").text
          @log.debug("\nSelected Product #{i} Name:   "+ @productNames[i])
          j=j+1
          break
      else
         j=j+1
      end
    end
    i=i+1    
  end  
  
  #Add to bag button element verification and clicking on it
  wait_until { page.find(:xpath, @xpath['xpath_add_bag_button']).visible? }
  if (page.has_xpath?(@xpath['xpath_add_bag_button']))
    page.find(:xpath,@xpath['xpath_add_bag_button']).click
    @log.debug("Clicked the Add To Bag Button Click element")
  else
    @log.debug("Could not able to click the Add To Bag element")
  end
  #Continue shopping button element verification and clicking on it
  wait_until { page.find(:xpath, @xpath['xpath_continue_shopping_button']).visible? }
  if (page.has_xpath?(@xpath['xpath_continue_shopping_button']))
    page.find(:xpath,@xpath['xpath_continue_shopping_button']).click
    @log.debug("Clicked the Continue Shopping Button Click element")
  else
    @log.debug("Could not able to click the Continue Shopping element")
  end 
end

Then /^Verify that successfully see product in bag$/ do
  wait_until { page.find(:xpath, @xpath['xpath_mybag_button']).visible? }
  if (page.has_xpath?(@xpath['xpath_mybag_button']))
    page.find(:xpath,@xpath['xpath_mybag_button']).click
    @log.debug("Clicked the Shopping Bag Button Click element")
  else
    @log.debug("\nCould not able to click the Shopping Bag element")
  end         
end

When /^Add "([^']*)" non-registry items to bag$/ do |number_of_item|
  counter=1
  start_loop=1
  end_loop=(@value["#{number_of_item}"]).to_i
  while(start_loop<=end_loop)
    #Main Menu verification and Clicking on it
    wait_until{page.find(:xpath,@xpath['xpath_mainmenus']).visible?}
     if(page.has_xpath? @xpath['xpath_mainmenus'])
      page.all(:xpath,@xpath['xpath_mainmenus']).sample.click
      @log.debug("Clicked the Main Menu")
    end
    #Iterate the loop until product thumbnails is present
    while(!((page.has_xpath? @xpath['xpath_product_thumbnails']) || (page.has_xpath? @xpath['xpath_product_wethumbnails']) || (page.has_xpath? @xpath['xpath_product_thumbnails1'])))
      if(page.has_xpath? @xpath['xpath_submenus'])
      page.all(:xpath,@xpath['xpath_submenus']).sample.click
      @log.debug("Clicked the Sub Menu")
      end  
          #Product thumbnails is verification and clicking on it
      if (page.has_xpath? @xpath['xpath_product_thumbnails'])
      page.all(:xpath,@xpath['xpath_product_thumbnails']).sample.click
      @log.debug("Product #{start_loop} is selected")
      break
      else
        #Product thumbnails is verification and clicking on it
        if(page.has_xpath? @xpath['xpath_product_wethumbnails'])
        page.all(:xpath, ['xpath_product_wethumbnails']).sample.click
        @log.debug("Product #{start_loop} is selected")
        break
        else
          #Product thumbnails is verification and clicking on it
          if(page.has_xpath? @xpath['xpath_product_thumbnails1'])
            page.all(:xpath, @xpath['xpath_product_thumbnails1']).sample.click
             @log.debug("Product #{start_loop} is selected")
            break
          else if(counter>=4) #terminate from the loop after 4 iteration, if product is not present 
            @log.debug("There is a problem in Clicking sub category")
            break
          else
            counter=counter+1
          end
        end
      end
    end
  end
 
  #Master product verification
  if (page.has_xpath? @xpath['xpath_check_masterproduct'])
      page.find(:xpath,@xpath['xpath_check_masterproduct']).click
      #Master Product Verification and Selection
      wait_until{page.find(:xpath,@xpath['xpath_master_product']).visible?}
      if (page.has_xpath? @xpath['xpath_master_product'])
         page.all(:xpath,@xpath['xpath_master_product']).sample.click
      else if (page.has_xpath? @xpath['xpath_master_product2'])
         page.all(:xpath,@xpath['xpath_master_product2']).sample.click
       end
     end
      #Master Product Full detail link verification
      wait_until{page.find(:xpath,@xpath['xpath_master_product_fulldetail']).visible?}
      if (page.has_xpath? @xpath['xpath_master_product_fulldetail'])
        page.find(:xpath, @xpath['xpath_master_product_fulldetail']).click
      end
  end     
   
  #Check and Select Color verification 
  #if(page.has_xpath? @xpath['xpath_color_size_class'])
    if (page.has_xpath? @xpath['xpath_product_color'])
      @log.debug("Color is available for this selected Product #{start_loop}")
      page.all(:xpath,@xpath['xpath_product_select_color']).sample.click
    end
  #end
 
  #Check and Select size verification
  #if (page.has_xpath? @xpath['xpath_color_size_class'])
    if (page.has_xpath? @xpath['xpath_product_size'])
      # Iterate through all the sizes and find the available one
      @log.debug("Size is available for this selected Product #{start_loop}")
      page.all(:xpath, @xpath['xpath_product_select_size']).each do |node|
      size_class = node[:class]
      size_index = size_class.index("disabled")
      if (size_index == nil)  
        node.click
        node.click
        break
      end
    end
  #end 
 end
 
 #Add to Bag button verification and clicking on it from product page
 wait_until{page.find(:xpath, @xpath['xpath_add_to_bag']).visible?}
 if(page.has_xpath? @xpath['xpath_add_to_bag'])
   page.find(:xpath, @xpath['xpath_add_to_bag']).click
   @log.debug("Add to bag button is clicked for selected Product #{start_loop}")
 end
#Continue shopping button verification and clicking on it from product page
wait_until{page.find(:xpath, @xpath['xpath_continue_shopping']).visible?}
if (page.has_xpath?(@xpath['xpath_continue_shopping']) && start_loop!=end_loop)
    page.find(:xpath, @xpath['xpath_continue_shopping']).click
    @log.debug("Selected product added and clicked Continue Shopping button")
end
 start_loop=start_loop+1
end
end

Then /^Click on Checkout Option$/ do
  wait_until { page.find(:xpath, @xpath['xpath_checkout']).visible? }
  if (page.has_xpath?(@xpath['xpath_checkout']))
    page.find(:xpath,@xpath['xpath_checkout']).click
    @log.debug("Clicked the Continue Check Out Button Click element") 
  else
    @log.debug("Could not able to click the Continue Check Out element")
  end
end

Then /^Verify the Express Checkout Option is suppressed in shopping bag page$/ do
   wait_until { page.find(:xpath, @xpath['xpath_continue_checkout']).visible? }
   if(page.find(:xpath,@xpath['xpath_express_checkout']))
      @log.debug("Express Check Out Button is available in shopping bag page")
   else
      @log.debug("Express Checkout Option is suppressed in shopping bag page as Expected.") 
   end
end

#click on Continue checkout..
And /^Click on Continue Checkout button$/ do
wait_until { page.find(:xpath, @xpath['xpath_continue_checkout']).visible?}
  if (page.has_xpath?(@xpath['xpath_continue_checkout']))
    page.find(:xpath,@xpath['xpath_continue_checkout']).click   
  else
    @log.debug("Could not able to click the Continue Check Out element !!!")
  end
end

And /^Verify that multiple shipping addresses option should be selected by default$/ do
  if (page.has_xpath?(@xpath['xpath_mul_ship_addr_option']))
    @log.debug("The Multiple shipping addresses option should be selected by default")
  else
    @log.debug("The Multiple shipping addresses option is not selected by default") 
  end  
end

And /^Verify that Registrant address should be suppressed and the message should be displayed$/ do
  @pageContent="Registrant's address is not shown for privacy."  
  if (page.has_content? @xpath['txt_registrant_address'])
    @log.debug("Registrant address should be suppressed and the message is displayed")
  else
    @log.debug("Registrant address is not displaying") 
  end   
end

And /^Verify that Registrant address and registry item should be displayed with registry icon$/ do
  if (page.find(:xpath, @xpath['xpath_registry_icon']).visible?)
      @log.debug("Registrant address and registry item should be displayed with registry icon")
  else
      @log.debug("Registrant address and registry item is not displayed with registry icon")
  end  
end

And /^Verify that the registrant and co-registrant names both should be displayed$/ do
  if ((page.has_content? @firstName) || (page.has_content? @lastName))
    @log.debug("Displayed the other registrant name successfully")
  else
    @log.debug("Not displayed the other registrant's name")
  end
end

And /^Verify that link to GVR should be displayed next to Registrants$/ do
  if (page.has_link? @xpath['txt_linkToGVRPage'])
    @log.debug("Link to GVR should be displayed next to Registrants")
  else
    @log.debug("Link to GVR is not displayed next to Registrants")
  end 
end

When /^I select on Registrant Address option$/ do
  choose(@xpath['check_registrant_adderess'])
  @log.debug("Registrant Address option is selected")
end

And /^Click on Checkout Option from shopping bag page$/ do  
  wait_until { page.find(:xpath, @xpath['xpath_continue_button']).visible? }
  if (page.has_xpath?(@xpath['xpath_continue_button']))
    page.find(:xpath,@xpath['xpath_continue_button']).click
    @log.debug("Clicked the Continue Check Out Button Click element") 
  else
    @log.debug("Could not able to click the Continue Check Out element")
  end
end

And /^Verify that Is this order a gift should be set to yes by default$/ do
  if (page.has_xpath?(@xpath['xpath_order_gift_option']))
    @log.debug("The 'Is this order a gift' is setted to yes by default")
  else
    @log.debug("The 'Is this order a gift' is not setted to yes by default") 
  end  
end

And /^Verify that Registrant Go Green message should be displayed$/ do
  if (page.has_content? @xpath['txt_goGreenMessage'])
    @log.debug("Go Green Message is displayed")
  else
    @log.debug("Go Green is not displayed") 
  end   
end

When /^I entered security code as "([^']*)" in payment details page$/ do |security_code|
  #Security Code text box verification and entering data
  wait_until { page.find(:xpath, @xpath['xpath_security_code_txtbox']).visible? }
  if (page.has_xpath?(@xpath['xpath_security_code_txtbox']))
    fill_in @xpath['txt_security_code'], :with => @value["#{security_code}"]
    @log.debug("Successfully Entered the security code")
  else
    @log.debug("Security Code text box in not loaded successfully")
  end
end

When /^I choose non-registry items from shipping address page$/ do
  if(page.has_content? @xpath['shipment1'])
      check @xpath['check1']
      check @xpath['check2']
  else
   @log.debug("Navigate to wrong page instead of shipment #1....")
  end
end

And /^I verify by default my own profile address for non-registry items$/ do
  if (page.has_content? @xpath['shipAdd1']) 
     if (page.has_xpath? @xpath['xpath_own_Profile'])
        @log.debug("By default your own profile address is selected...")
     else
        @log.debug("its not your profile address...")
     end
  else
        @log.debug("Navigate to wrong page instead of address for shipment #1.....")
  end
end


And /^I choose non-registry items from shipping option page$/ do
  if(page.has_content? @xpath['Option1'])
    @log.debug("Now Are you in Shipment Option1 page.... :")
  else
    @log.debug("Navigate to wrong page instead of shipment option #1....")
  end
end

When /^I choose Registry items from shipping address page$/ do
  if(page.has_content? @xpath['shipment2'])
    check @xpath['check1']
    check @xpath['check2']
  else
    @log.debug("Navigate to wrong page instead of shipment #2....")
  end
end

And /^I verify by default Registry's address for registry items$/ do
if(page.has_content? @xpath['shipAdd2'])
    @log.debug("Now Are you in  address Shipment2 page.... :")
else
   @log.debug("Navigate to wrong page instead of address shipment2....")
end
wait_until{page.find(:xpath,@xpath['xpath_co_Registry']).visible?}
if (page.has_xpath? @xpath['xpath_co_Registry']) 
        @log.debug("By default Registry's address is selected....")
   if (page.has_content? @xpath['RegAdd'])
        @log.debug("Registry's address not displaying message getting displayed....")
   else
        @log.debug("Its not Registry's address...")
   end
else
    @log.debug("Navigate to wrong page instead of address for shipment #2.....")
end
end

And /^I choose registry items from shipping option page$/ do
  if(page.has_content? @xpath['Option2'])
    @log.debug("Now Are you in Shipment Option_2 page.... :")
  else
    @log.debug("Navigate to wrong page instead of shipment option #2....")
  end
end

And /^verify review your shipments page$/ do
  if(page.has_content? @xpath['review'])
    @log.debug("Now Are you in review your shipments page.... :")
  else
    @log.debug("Navigate to wrong page instead of review your shipments....")
  end
end


#Click on Create Registry button.
And /^I click on Create Register button$/ do
  wait_until{page.find(:xpath, @xpath['Create_Reg']).visible?}
  if (page.find(:xpath, @xpath['Create_Reg']).visible?)
   page.find(:xpath, @xpath['Create_Reg']).click
  else
   @log.debug("Create Register button is not available")
  end
end  
  
When /^I enter the Email Address and password "([^']*)" and "([^']*)" details$/ do |username, password| 
  #Entering name and password fields 
      within(:xpath, @xpath['Email_form']) do    
       fill_in(@xpath['txt_email'],:with => @value["#{username}"])   
       fill_in(@xpath['txt_password'],:with => @value["#{password}"])
      end
end
  
# Clicked on Create Registry button  
Then /^I click on CREATE REGISTRY button$/ do
wait_until{page.find(:xpath, @xpath['Create_Reg_button']).visible?}
  if (page.has_xpath?@xpath['Create_Reg_button'])
    page.find(:xpath, @xpath['Create_Reg_button']).click 
  else 
    @log.debug("Could not able to click the CREATE REGISTRY LOGIN PAGE button...")
  end
end

#purchase a product and add to resistry..
And /^I purchase "([^']*)" registry items$/ do |numberReg|
@counter=1
@start=1
@end=@value["#{numberReg}"].to_i
while(@start<=@end)
$count = page.all('#globalNav ul li').count

$count = $count-1
$icount = $count.to_i
$random = rand($icount)
$random = $random + 1
if $random == 1
  $random=$random+1
end
 page.find(:xpath, "//div[@id='globalNav']/ul/li[#$random]/a").click
    while(!((page.has_xpath? @xpath['xpath_product_thumbnails']) || (page.has_xpath? @xpath['xpath_product_wethumbnails']) || (page.has_xpath? @xpath['xpath_product_thumbnails1'])))
      if(page.has_xpath? @xpath['xpath_submenus'])
      page.all(:xpath,@xpath['xpath_submenus']).sample.click      
      end        
      if (page.has_xpath? @xpath['xpath_product_thumbnails'])
      page.all(:xpath,  @xpath['xpath_product_thumbnails']).sample.click
      break
      else
        if(page.has_xpath? @xpath['xpath_product_wethumbnails'])
        page.all(:xpath, @xpath['xpath_product_wethumbnails']).sample.click
        break
        else
          if(page.has_xpath? @xpath['xpath_product_thumbnails1'])
            page.all(:xpath, @xpath['xpath_product_thumbnails1']).sample.click
            break
          else
          if(@counter>=4)           
            break
          else
            @counter=@counter+1
          end
        end
      end
    end
  end
#Master product verification

  if (page.has_xpath? @xpath['xpath_check_masterproduct'])      
      page.find(:xpath,@xpath['xpath_check_masterproduct']).click
      #Master Product Verification and Selection
      if (page.has_xpath? @xpath['xpath_master_product'])
         page.all(:xpath,@xpath['xpath_master_product']).sample.click        
      else if (page.has_xpath? @xpath['xpath_master_product2'])
         page.all(:xpath,@xpath['xpath_master_product2']).sample.click        
           end
      end
      #Master Product Full detail link verification
      wait_until{page.find(:xpath,@xpath['xpath_master_product_fulldetail']).visible?}
      if (page.has_xpath? @xpath['xpath_master_product_fulldetail'])
        page.find(:xpath, @xpath['xpath_master_product_fulldetail']).click
      end
  end     
   
  #Check and Select Color verification 
     if (page.has_xpath? @xpath['xpath_product_color'])      
      page.all(:xpath,@xpath['xpath_product_select_color']).sample.click
    end

  #Check and Select size verification
    if (page.has_xpath? @xpath['xpath_product_size'])
      # Iterate through all the sizes and find the available one      
      page.all(:xpath, @xpath['xpath_product_select_size']).each do |node|
      size_class = node[:class]
      size_index = size_class.index("disabled")
      if (size_index == nil)  
        node.click
        node.click
        break
      end
    end
 end
wait_until{page.find(:xpath,@xpath['xpath_add_to_reg']).visible?}
if(page.has_xpath? @xpath['xpath_add_to_reg'])
  page.find(:xpath, @xpath['xpath_add_to_reg']).click  
end
#click on view registry item..
wait_until{page.find(:xpath,@xpath['xpath_viewregistry']).visible?}
if (page.has_xpath? @xpath['xpath_viewregistry'])
    page.find(:xpath, @xpath['xpath_viewregistry']).click
    @log.debug("Selected product added to registry")
end
@start=@start+1
 end
end

#Add the product from Registry to Bag
When /^From My Registry page, add "([^']*)" items from registry to bag$/ do |number_of_regitem|
  i=0
  j=1
  numberReg1=@value["#{number_of_regitem}"].to_i
  while(i<numberReg1)
     while(page.has_xpath?("//table[@class='registryTable']/tbody/tr[#{j}]"))
      if(page.has_xpath?("//table[@class='registryTable']/tbody/tr[#{j}]/td[7]"))
          page.find(:xpath, "//table[@class='registryTable']/tbody/tr[#{j}]/td[7]/div/div/select/option[2]").click
          j=j+1
          break
      else
         j=j+1
      end
    end
    i=i+1   
  end 
  
  #Add to bag button element verification and clicking on it
  wait_until { page.find(:xpath, @xpath['xpath_add_bag_button']).visible? }
  if (page.has_xpath?(@xpath['xpath_add_bag_button']))
    page.find(:xpath,@xpath['xpath_add_bag_button']).click
  else
    @log.debug("\n Could not able to click the Add To Bag element !!!")
  end
  #Checkout button element verification and clicking on it
  wait_until { page.find(:xpath, @xpath['xpath_checkout']).visible? }
  if (page.has_xpath?(@xpath['xpath_checkout']))
    page.find(:xpath,@xpath['xpath_checkout']).click
    @log.debug("Clicked the CheckOut element..!!!")
  else
    @log.debug("Could not able to click the CheckOut element !!!")
  end 
end

And /^I click on Wedding and Gift registry page$/ do
  page.find(:xpath, @xpath['Wed_Registry_page']).click
 end
 
When /^I check if the shipment link and back to registry are available$/ do 
# Check if View Items in Shipment link is displayed  
  if (page.find(:xpath, @xpath['xpath_openshipment']).visible?)
   @log.debug("View Items in Shipment link is displayed successfully!!!!!!!")
  else
   @log.debug("View Items in Shipment link is not displayed successfully")
  end
  
  # Check if Back to Registry button is available
  if (page.has_link? @xpath['txt_linkToGVRPage'])
   @log.debug("Here showing couple's registry items & non-registry items...") 
  else
   @log.debug("back to registry button is not available, since couple registry details are not displayed in this page...")
  end
end 
 

When /^I choose registrant items from shipping address page$/ do
  if(page.has_content? @xpath['shipment3'])    
    check @xpath['check1']
    check @xpath['check2']
  else
    @log.debug("Navigate to wrong page instead of shipment #3....")
  end
end



And /^I verify by default my own profile address for Registrant items$/ do
if (page.has_content? @xpath['shipAdd3']) 
    @log.debug("Now Are you in address shipment3 page....")
     if (page.has_xpath? @xpath['xpath_own_Profile'])
      @log.debug("By default your own profile address is selected...")     
     else
      @log.debug("its not your profile address...")
    end
  else
    @log.debug("Navigate to wrong page instead of address for shipment #3.....")
  end
end


And /^I choose Registrant items from shipping option page$/ do
  if(page.has_content? @xpath['Option3'])
    @log.debug("Now Are you in Shipment Option3 page.... :")
  else
    @log.debug("Navigate to wrong page instead of shipment option #3....")
  end
end
  