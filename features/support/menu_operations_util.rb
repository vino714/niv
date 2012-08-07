# Create By : Saravanan Alagarsamy / YC30sa1
# Contents : This file contains different classes related to menu[categories] and submenu[sub categories]
# Description : The class 'MainCategories' will hold required operations as self methods for the main manu  
# The class 'SubCategories' will hold all required operations as self methods for 'sub categories' for the left panel
#------------------------------------------------------------
class MainCategories
  # xpath to select all available menus / categories
  @xpath_mainmenus = "//div[@id='globalNav']/ul/li/a/img"

  #Description : Randomly click one main category form the avaialble list of main categories
  def self.click_random_menu
    page.all(:xpath,@xpath_mainmenus).sample.click
  end
end

#Example : Accessing the method "click_random_menu"
#----------------------------------------------------- 
# MainCategories.click_random_menu
#-----------------------------------------------------

class SubCategories
  
  # xpath to select all available sub-menus / sub-categories
  @xpath_submenus = "//div[@id='localNavigationContainer']/ul/li/ul/li/a"

  
  #Description : Randomly selected one sub category form the avaialble
  def self.click_random_subcategory
    page.all(:xpath,@xpath_submenus).sample.click
  end
end

#Example : Accessing the method "click_random_subcategory"
#----------------------------------------------------- 
# SubCategories.click_random_subcategory
#-----------------------------------------------------



