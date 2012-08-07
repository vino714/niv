# Create By : Saravanan Alagarsamy / YC30sa1
# Contents : This file contains different classes related to product categories
# Description : The class 'Products' will hold required operations as self methods for the invidual products  

class Products
   #xpath to select all product from the first page
  @xpath_product_thumbnails = "//div[@id='thumbnails']/div/div/div/a"

  #Description : Randomly click one product from the first page
  def self.click_random_product_from_thumbnail
    page.all(:xpath,@xpath_product_thumbnails).sample.click
  end
end

#Example : Accessing the method "click_random_product_from_thumbnail"
#----------------------------------------------------- 
# Products.click_random_product_from_thumbnail
#-----------------------------------------------------
