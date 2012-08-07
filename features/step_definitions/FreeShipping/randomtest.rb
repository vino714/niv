#Random Menu Selection
Then /^I select a menu randomly$/ do
  if(page.find(:xpath, @xpath['mainmenus']).visible?)
    page.all(:xpath, @xpath['mainmenus']).sample.click
  end
end

#Random Submenu Selection
And /^I select a submenu randomly$/ do
  if(page.has_xpath?@xpath['submenu_container'])
    page.all(:xpath, @xpath['submenus']).sample.click
  else
    steps %Q{
        Then I select a menu randomly
        And I select a submenu randomly
      }
  end  
end

#Random Product Selection with price range
And /^I add products ranging from "([^"]*)" to "([^"]*)" numbering "([^"]*)"$/ do |fromVal, toVal, quantity|
  if((page.has_xpath? @xpath['product_thumbnails']) || (page.has_xpath? @xpath['product_wethumbnails']) || (page.has_xpath? @xpath['product_thumbnails1']))
    #Range Fixing
    if (page.has_xpath?@xpath['fromRangeId'])       
      fill_in @xpath['fromValue'], :with=> fromVal
      fill_in @xpath['toValue'], :with=> toVal
      page.find(:xpath, @xpath['filterButton']).click
      wait_until{page.find(:xpath, @xpath['facet_breadcrump']).visible?}
      if(page.has_xpath?@xpath['price_msg'])
          steps %Q{
          Then I select a menu randomly
          And I select a submenu randomly
          And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}" 
         }
      end
    else
      steps %Q{
        Then I select a menu randomly
        And I select a submenu randomly
        And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}"
      }
    end
    
    #Checking for Price range is available or not
    if(page.has_xpath?@xpath['noPrice_okBtn'])
      page.find(:xpath, @xpath['noPrice_okBtn']).click
        steps %Q{
          Then I select a menu randomly
          And I select a submenu randomly
          And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}"
        }
    else
      #Selecting product
      if(page.has_xpath?@xpath['macysGlobalContainer'])
        if page.has_xpath?@xpath['product_thumbnails_filter']
          page.find(:xpath, @xpath['product_thumbnails_filter']).click
        elsif page.has_xpath?@xpath['product_wethumbnails_filter']
            page.find(:xpath, @xpath['product_wethumbnails_filter']).click
        elsif page.has_xpath?@xpath['product_thumbnails1_filter']
            page.find(:xpath, @xpath['product_thumbnails1_filter']).click
        else
          steps %Q{
            Then I select a menu randomly
            And I select a submenu randomly
            And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}"
          }
          end
        end
      if page.has_xpath?@xpath['selectQuantityId']
        select(quantity, :from => @xpath['product_quantity'])
        if page.has_xpath?@xpath['color']
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
        
        #Add to Bag
        wait_until{page.find(:xpath, @xpath['add_to_bag_img']).visible?}
        page.find(:xpath, @xpath['add_to_bag_img']).click
        wait_until{page.find(:xpath, @xpath['continue_shopping']).visible?}
        page.find(:xpath, @xpath['continue_shopping']).click
      else  #Selecting quantity select box loop
        steps %Q{
          Then I select a menu randomly
          And I select a submenu randomly
          And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}"
        }
      end   #select box loop ends
    end
  else  #Initial loop for thumbnail ends
    steps %Q{
        Then I select a menu randomly
        And I select a submenu randomly
        And I add products ranging from "#{fromVal}" to "#{toVal}" numbering "#{quantity}"
      }
  end  
end