

def nav_menu(menu)
  navmenu = menu.gsub(/\s+/, "")
  navmenu.gsub(/&/,"")
  return navmenu
end

And /^I select "([^"]*)" from the navigation menu$/ do |menu_choice|
  @checkoutfileLoad=false
  config_data_file = "config/CHKOUT/xpaths.yml"
  @config_data_file=YAML::load(File.open(config_data_file))
  @checkoutfileLoad=true  
  #Random Selection for main menu
  if (menu_choice == "random")
  @xpath_mainmenus=@config_data_file['xpath_mainmenus']
  page.all(:xpath,@xpath_mainmenus).sample.click
  else
  #Static Selection for main menu
  menu = nav_menu(menu_choice)
  selection = @navigation_file['navigation']["#{menu}"]
  click_link selection
  end
end

When /^I select the category "([^"]*)"$/ do |category|
 @xpath_submenus = @config_data_file['xpath_submenus']
 $category_name=page.all(:xpath,@xpath_submenus).sample.text
 #Random Selection of Category
 if (category == "random")
 click_link $category_name
  else
  #Static Selection for Category
  click_link category
  end
end

When /^I select the subcategory "([^"]*)"$/ do |sub_category|
  if (sub_category == "random")
  @xpath_subcategory = "//div[@id='facets']/div"
  puts "#{@xpath_subcategory}"
 $subcategory_name=page.all(:xpath,@xpath_subcategory).sample.click
  else
  click_link sub_category
  end
end

Then /^I click on checkout button$/ do
  ids_data_file = "config/data/qa/ids.yml"
  @ids_data_file = YAML::load(File.open(ids_data_file))
  #Retriveing Data from YML ids.yml
  @checkout_btn1=@ids_data_file['checkout_btn1']
  @checkout_btn2=@ids_data_file['checkout_btn2']
  @checkout_check_btn_id=@ids_data_file['checkout_check_btn_id']
  if page.has_xpath? @checkout_check_btn_id
      page.find(:xpath,@checkout_btn1).click
   else
      page.find(:xpath,@checkout_btn2).click
 end
end
 
When /^I click continuecheckout$/ do
  loadchkconfig()
  @merch_total_details=@config_data_file['merch_total_details']
  @checkout_btn=@config_data_file['checkout_btn']
  wait_until{page.find(:xpath, @merch_total_details).visible?}
  $item_dollar=page.find(:xpath, @merch_total_details).text
  #spliting $ from the price
  priceA =$item_dollar.split("$")
  $item_dollar = priceA[1].strip
  wait_until { page.find(:xpath,@checkout_btn).visible? }
  page.find(:xpath,@checkout_btn).click
end

Then /^I should see the current category$/ do
  puts "I am on #{$category_name} category"
end

When /^I select any item from collection$/ do
loadchkconfig()
@xpath_product_thumbnails = @config_data_file['xpath_product_thumbnails']
@xpath_product_wethumbnails = @config_data_file['xpath_product_wethumbnails']
@xpath_product_thumbnails1 = @config_data_file['xpath_product_thumbnails1']
  if page.has_xpath? @xpath_product_thumbnails
      page.all(:xpath,@xpath_product_thumbnails).sample.click
      else if page.has_xpath? @xpath_product_wethumbnails 
        page.all(:xpath,@xpath_product_wethumbnails).sample.click
        else if page.has_xpath? @xpath_product_wethumbnails1
            page.all(:xpath,@xpath_product_thumbnails1).sample.click
          else
            #Repeat the Steps if products is Not Visible
              steps %Q{
                      And I select "random" from the navigation menu
                      When I select the category "random"
                      Then I should see the current category
                      When I select any item from collection
                       }          
        end
      end
  end
end

#When /^I select the "([^"]*)" product$/ do |arg1|
 # pending # express the regexp above with the code you wish you had
#end

When /^I select quick view from the "([^"]*)" product$/ do |arg1|
  visit("http://www1.macys.com/catalog/product/quickview/?id=614000")
end

Then /^I should see the quick view overlay$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I select "([^"]*)" from the size pulldown$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


Then /^I should see the "([^"]*)" shipping availability message$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I click "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I am on the shopping bag page as a "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^my item\(s\) are in the shopping bag$/ do
  pending # Based on an array that keeps WebID, Qty, and Price
  #  for i = 0, i < length of bag array, i++ 
  #  Webid = array[i][0]
  #  QTY = array[i][1]
  #  Price = array[i][2]
  #   steps %Q{
  #  Then I should see correct "WEBID"
  #  Then I should see the correct "QTY"
  #  Then I should see the correct "PRICE"
end

Then /^my merchandise total is correct$/ do
  pending # express the regexp above with the code you wish you had
  #Get total from step_def Then my items are in the shopping bag, check to make sure not null
  #Subtract total from promotion saving
end

def loadchkconfig()
  @checkoutfileLoad=false
  config_data_file = "config/CHKOUT/xpaths.yml"
  @config_data_file=YAML::load(File.open(config_data_file))
  @checkoutfileLoad=true  
end