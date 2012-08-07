When /^I click on the WEDDING REGISTRY link$/ do   
# I click on the create registry link in the home page   
  #Adding xpath file
  xpath_file = "config/registry/xpaths.yml"
  @xpathreg = YAML::load(File.open(xpath_file))
  
  #Adding Values file
  value_file = "config/registry/values.yml"
  @valuereg = YAML::load(File.open(value_file))

  #Clicking on wedding registry
  wait_until{page.find(:xpath, @xpathreg['menu_wedReg']).visible?}
  page.find(:xpath, @xpathreg['menu_wedReg']).click
  @log.debug("Clicked on the Wedding registry Link successfully")
end
  
And /^I click on Create Registry$/ do
  #Clicking on the create registry to create new registry 
  wait_until{page.find(:xpath, @xpathreg['createReg_circle']).visible?}
  #check if the create registry button is visible  
  if (page.find(:xpath, @xpathreg['createReg_circle']).visible?)
  #click on the create registry button if it is visible    
    page.find(:xpath, @xpathreg['createReg_circle']).click
    @log.debug("Clicked on the create registry button successfully")
  else
    # record error if create registry button is not available  
    @log.debug(" Not Clicked on the create registry button as it is not visible")
  end
end  

When /^I enter the necessary credentials to create new registry$/ do
  # Check if the create user without profile button is visible 
  wait_until{page.find(:xpath, @xpathreg['createUser_withoutProfile']).visible?}
  # get the time stamp
  timeNow = Time.now
  timeNow = timeNow.to_i
  timeNow = (timeNow/2).to_s
  #generate a mail id with timestamp attached to make it unique every time automation runs 
  email = 'testuser'+timeNow+'@gmail.com'
  # Use the mail and password within right pane in the create registry page
  within("form#registrySignInVB") do
    #enter the details of mail and password
    fill_in(@xpathreg['email'], :with => email)
    fill_in(@xpathreg['verify_email'], :with => email)
    fill_in(@xpathreg['password'], :with => @valuereg['password'])
    fill_in(@xpathreg['verify_password'], :with => @valuereg['password'])
    #Click on the create registry without profile button
    page.find(:xpath, @xpathreg['btn_createReg_withoutProfile']).click
    @log.debug("Clicked on the create registry without profile successfully")
  end
end


And /^I enter the other details to create new registry$/ do
  #Check if event details form is visible
  if page.has_content?'Event Type'
    # enter the details if the form is visible
    @log.debug("Navigated to create registry page")
    # Entering the event details
    select(@valuereg['reg_type'], :from => @xpathreg['registryType'])
    select(@valuereg['event_month'], :from => @xpathreg['event_month'])
    select(@valuereg['event_day'].to_s, :from => @xpathreg['event_day'])
    select(@valuereg['event_year'].to_s, :from => @xpathreg['event_year'])
    select(@valuereg['city'], :from => @xpathreg['event_location'])
    fill_in @xpathreg['guests_number'], :with => @valuereg['guests'].to_s
  
  #Contact Information
    fill_in @xpathreg['firstName'], :with => @valuereg['firstName']
    fill_in @xpathreg['lastName'], :with => @valuereg['lastName']
    fill_in @xpathreg['address'], :with => @valuereg['address']
    fill_in @xpathreg['city'], :with => @valuereg['city']
    select(@valuereg['city'], :from => @xpathreg['state'])
    fill_in @xpathreg['postalCode'], :with => @valuereg['zipcode'].to_s
  # Entering date of birth 
    select(@valuereg['birth_mon'], :from => @xpathreg['birth_month'])
    select(@valuereg['birth_date'].to_s, :from => @xpathreg['birth_day'])
    select(@valuereg['birth_year'].to_s, :from => @xpathreg['birth_year'])
  # Entering the phone details 
    fill_in @xpathreg['phone_areaCode'], :with => @valuereg['phone_areaCode'].to_s
    fill_in @xpathreg['phone_exchange'], :with => @valuereg['phone_exchange'].to_s
    fill_in @xpathreg['phone_number'], :with => @valuereg['phone_number'].to_s
  # Entering the password recovery details
    select(@valuereg['password_hint_question'], :from => @xpathreg['password_hint'])
    fill_in @xpathreg['password_answer'], :with => @valuereg['pass_ans']
  # Entering the CoRegistrant Details
    fill_in @xpathreg['coreg_firstName'], :with => @valuereg['coreg_firstName']
    fill_in @xpathreg['coreg_lastName'], :with => @valuereg['coreg_lastName']
  # Registry Preferences
    select(@valuereg['state'], :from => @xpathreg['store_state'])
    select(@valuereg['store_pref'], :from => @xpathreg['store_number'])
  # Entering the subscription details
    page.find(:xpath, @xpathreg['subscribe_wed']).click
    page.find(:xpath, @xpathreg['subscribe_mails']).click
  # Clicking on the register button
    page.find(:xpath, @xpathreg['btn_register']).click
    @log.debug("Filled in the details in the regisrty successfully")
  else
    # Logging error if not navigated to the page
    @log.debug("Not navigated to the create registry page")
  end
  end

Then /^I check the registry is created or not$/ do
  #Check whether registry created or not
  #wait for the side navigator to be visible
  wait_until{page.find(:xpath, @xpathreg['manage_navigation']).visible?}
  sideNavigator = page.find(:xpath, @xpathreg['manage_navigation'])
  # I find if the registry is created and store it in result
  result = sideNavigator.has_content?@xpathreg['edit_account']
  if result
    # Log the registry creation
    @log.debug("Created registry successfully")
  else
    # Log the error that registry is not created
    @log.debug("Registry not created successfully")
  end
end