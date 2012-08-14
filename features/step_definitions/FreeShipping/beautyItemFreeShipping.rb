#I enter into the macys.com and load the files
Given /^I am in MCOM site$/ do
  config_file = "config/#{ENV['ENVIRONMENT']}/navigation.yml"

  #Loaded file will be available throughout the execution of a scenario
  @navigation_file = YAML::load(File.open(config_file))
  
  #Adding xpath file
  xpath_file = "config/FreeShipping/xpaths.yml"
  @xpath = YAML::load(File.open(xpath_file))
  
  #Adding Values file
  value_file = "config/FreeShipping/values.yml"
  @value = YAML::load(File.open(value_file))

  ids_data_file = "config/data/qa/ids.yml"
  @ids_data_file = YAML::load(File.open(ids_data_file))
  
  # clear cookies
  # browser = Capybara.current_session.driver.browser
  # browser.manage.delete_all_cookies
  
  #Grab Variables From File
  # url = @navigation_file['url']
  visit ("#{$url}")
  @log.debug("Successfully entered macys.com")  
end

When /^I select beauty items menu$/ do
  wait_until{page.find(:xpath, @xpath['menu_beauty_cosmetics']).visible?}
  page.find(:xpath, @xpath['menu_beauty_cosmetics']).click
end

And /^I select a submenu from beauty items menu$/ do
  if(page.has_xpath?@xpath['submenu_container'])
    page.all(:xpath, @xpath['submenu_beauty_items']).sample.click
  else
    steps %Q{
        When I select beauty items menu
        And I select a submenu from beauty items menu
      }
  end
end

Then /^I select the product between "([^"]*)" and "([^"]*)" with "([^"]*)" numbers$/ do |fromVal, toVal, quantity|
  if((page.has_xpath? @xpath['product_thumbnails']) || (page.has_xpath? @xpath['product_wethumbnails']) || (page.has_xpath? @xpath['product_thumbnails1']))
    #Range Fixing
    if (page.has_xpath?@xpath['fromRangeId'])       
      fill_in @xpath['fromValue'], :with=> fromVal
      fill_in @xpath['toValue'], :with=> toVal
      page.find(:xpath, @xpath['filterButton']).click
      wait_until{page.find(:xpath, @xpath['facet_breadcrump']).visible?}
    else
      steps %Q{
        When I select beauty items menu
        And I select a submenu from beauty items menu
        Then I select the product between "#{fromVal}" and "#{toVal}" with "#{quantity}" numbers
      }
    end

   if(page.has_xpath?@xpath['macysGlobalContainer'])
        if page.has_xpath?@xpath['product_thumbnails_filter']
          page.find(:xpath, @xpath['product_thumbnails_filter']).click
        elsif page.has_xpath?@xpath['product_wethumbnails_filter']
            page.find(:xpath, @xpath['product_wethumbnails_filter']).click
        elsif page.has_xpath?@xpath['product_thumbnails1_filter']
            page.find(:xpath, @xpath['product_thumbnails1_filter']).click
        else
          steps %Q{
            When I select beauty items menu
            And I select a submenu from beauty items menu
            Then I select the product between "#{fromVal}" and "#{toVal}" with "#{quantity}" numbers
          }
          end
        end
    if page.has_xpath?@xpath['selectQuantityId']
      select(quantity, :from=> @xpath['product_quantity'])
      #Check and Select Color verification 
      if page.has_xpath?@xpath['color']
        puts "colour selected"
        page.all(:xpath, @xpath['color_val']).sample.click
      end
      
      #Size Verification
      if page.has_xpath?@xpath['master_size_val']
        page.all(:xpath, @xpath['master_size_val']).sample.click
      end
        
      #Select available size
      if page.has_xpath?@xpath['size']      
        # Iterate through all the sizes and find the available one
        page.all(:xpath, @xpath['size_val']).each do |node| 
          size_class = node[:class]
          size_index = size_class.index("disabled")
          if (size_index == nil)
            node.click
            node.click
            break
          end
        end
      end
      
      wait_until{page.find(:xpath, @xpath['add_to_bag_img']).visible?}
      page.find(:xpath, @xpath['add_to_bag_img']).click
      wait_until{page.find(:xpath, @xpath['continue_shopping']).visible?}
      page.find(:xpath, @xpath['continue_shopping']).click
    else
      steps %Q{
        When I select beauty items menu
        And I select a submenu from beauty items menu
        Then I select the product between "#{fromVal}" and "#{toVal}" with "#{quantity}" numbers
      }
    end
  else
    steps %Q{
        When I select beauty items menu
        And I select a submenu from beauty items menu
        Then I select the product between "#{fromVal}" and "#{toVal}" with "#{quantity}" numbers
      }
  end
end

#I add it to the shopping bag
And /^I go to the shopping bag$/ do 
  wait_until{page.find(:xpath, @xpath['add_to_bag_img']).visible?}
  page.find(:xpath, @xpath['add_to_bag_img']).click  
  wait_until{page.find(:xpath, @xpath['continue_shopping']).visible?}
  page.find(:xpath, @xpath['continue_shopping']).click
  @log.debug("Selecting beauty Items and adding it")
end

#I visit the shopping bag
And /^I goto shopping bag page to click estimated shipping$/ do
  page.find(:xpath, @xpath['checkout_toplink']).click
  wait_until{page.find(:xpath, @xpath['shopping_bag']).visible?}
  $res = page.has_content?'your shopping bag'
  if ($res.should == true)
    @log.debug("navigated to shopping bag")
  end
  pdtCount = page.all(:css, "#itemsContainer .secondary", :visible => true).count
  pdtCount = pdtCount.to_i
  if pdtCount > 1
    for i in 2..pdtCount
      puts "in for"
      page.find(:xpath, @xpath[shopping_bag_remove_link]).click
      wait_until{page.find(:xpath, @xpath['shopping_bag_content']).visible?}
    end
  end
  page.find(:xpath, @xpath['estimated_shipping']).click
  @log.debug("Visited the shopping bag and checking the item")
end

#I checkout till I go to the payment page 
Then /^I should see "([^"]*)" to checkout all pages$/ do |checkResult|
    popup = page.has_content?'Shipping Charge Details '
    if popup
      result = page.has_content?checkResult
      if result
        @log.debug("Result found : #{checkResult}")
      else
        @log.debug("#{checkResult} not found")
      end
    else
       @log.debug("Cant find any popups")
    end
    page.find(:xpath, @xpath['popup_close']).click
      wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
      page.find(:xpath,@xpath['continue_checkout']).click
      wait_until{page.find(:xpath, @xpath['continue']).visible?}
      page.find(:xpath, @xpath['continue']).click
      wait_until{page.find(:xpath, @xpath['continue_checkout']).visible?}
      page.find(:xpath, @xpath['continue_checkout']).click    
      fill_in @xpath['field_sec_id'], :with => @value['val_sec_id']
      page.find(:xpath, @xpath['continue_checkout']).click
  @log.debug("Check out Succesfully")
end