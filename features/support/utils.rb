# ***************************  Constants ****************************

# ***************************  Functions ****************************

def get_env()
  return "/#{ENV['ENVIRONMENT']}"
end

def sign_in(email, magicword)
  click_link('sign in')
  fill_in('email', :with => email)
  fill_in('password', :with => magicword)
  page.find(:xpath, "//input[@name='accountSignIn']").click
end

def wait_until_entity_exists(type, element, timeout, other1)
  ctr1 = 0
  found = false
  while (!found && ctr1 < timeout)
    sleep 1
    ctr1 += 1
    case type
      when 'text'
        if page.has_content?(element)
          found = true
        end
      when 'input_id'
        if page.find(:xpath, "//input[@id='#{element}']")
          found = true
        end
      when 'img_title'
        if page.find(:xpath, "//img[@title='#{element}']")
          found = true
        end
      when 'img_id'
        if page.find(:xpath, "//img[@id='#{element}']")
          found = true
        end
      when 'path'
        if page.find(:xpath, element)
        found = true
        end
    end
  end
  if found == false
      raise "Count not find the item: " + element + ". Timed out"
   end
end


def wait_until_value_exists(type, element, timeout, other1)
  ctr1 = 0
  found = false
  while (!found && ctr1 < timeout)
    sleep 1
    ctr1 += 1
    case type
      when 'input_id'
        if page.find(:xpath, "//input[@id='#{element}']").value != nil
          found = true
        end
    end
  end
  if found == false
      raise "Count not find the item: " + element + ". Timed out"
   end
end

def random_number
  random_number_1 = rand(499999)
  random_number_string =  random_number_1.to_s.rjust(6,'0')
  return random_number_string
end

def is_page_secured
  browser = Capybara.current_session
  curr_url = browser.current_url
  if (curr_url.index("https") == nil)
    raise "Page is not secured page"
  end
end

def key_press(id, key)
  key = key.upcase
  case key
    when 'ENTER'
      keycode = 13
    when 'LEFT ARROW'
      keycode = 37
    when 'RIGHT ARROW'
      keycode = 39
    when 'UP ARROW'
      keycode = 38
    when 'DOWN ARROW'
      keycode = 40
    end
  browser = Capybara.current_session
  browser.execute_script('event = document.createEvent("KeyboardEvent");')
  browser.execute_script('event.initKeyEvent("keydown", true, false, document.window, false, false, false, false, ' + keycode.to_s + ', 0)')
  browser.execute_script("document.getElementById('#{id}').dispatchEvent(event)")
end

def validate_thumbnails_and_color(path, attribute, color, thumbnail)
  t_nail_found = false  
  page.all(:xpath, path).each do |t_nail|
    div_id = t_nail['id']
    style_url = page.find(:xpath, "//div[@id='#{div_id}']/img")[attribute]
    if style_url.include?(thumbnail)
      t_nail_found = true
      page.find(:xpath, "//div[@id='#{div_id}']/div").text.should == color
      break
    end
  end
  if t_nail_found == false
    raise "Thumbnail: #{thumbnail} not found"
  end  
end

def validate_thumbnails(path, attribute, item)
  t_nail_found = false  
  page.all(:xpath, path).each do |t_nail|
    src_url = t_nail[attribute]
    if src_url.include?(item)
      t_nail_found = true
      break
    end
  end
  if t_nail_found == false
    raise "Thumbnail: #{item} not found"
  end  
end

def validate_product_images(path, attribute, item)
  t_nail_found = false  
  page.all(:xpath, path).each do |t_nail|
    src_url = t_nail[attribute]
    if src_url.include?('?') & src_url.include?('.') & src_url.include?('image')
      t_nail_found = true
      break
    end
  end
  if t_nail_found == false
    raise "Thumbnail: #{item} not found"
  end  
end

def validate_text(path, item)
  item_found = false  
  page.all(:xpath, path).each do |element|
    iter_item = element.text
    if iter_item.include?(item)
      item_found = true
      break
    end
  end
  if item_found == false
    raise "Text: #{item} not found"
  end  
end

def trim_end_characters(phrase)
  return phrase[1,phrase.length-2] 
end

def validate_image(div_id)
  src_string = page.find(:xpath, ".//div[@class='#{div_id}']/img")['src']
  src_string.include?('image').should == true
  src_string.include?('.').should == true
  src_string.include?('?').should == true
end 

def selectcolor()
  @colorContainer = @config_data_file['pdp_colorContainer']
   if(page.has_xpath?(@colorContainer))
    puts "Colors exist for this product"
  end
  @color = @config_data_file['pdp_color']
  if(page.has_xpath?(@color))
    page.find(:xpath,@color).click
  end
end

def selectsize()
  @available_size = @config_data_file['pdp_size_available']
  if(page.has_xpath?(@available_size))
    size_names = Array.new
    page.all(:xpath, @available_size).each do |sizename|
      sizenames =  sizename['title']
      size_names << sizenames
    end
    puts "**************size names********************"
    puts size_names
    count = size_names.size
    random=rand(1..count)
    page.find(:xpath,@available_size+"['#{random}']/span").click
  end
end

# ***************************  Steps ****************************

When /^I debug_sleep for (\d+) seconds$/ do |seconds|
  puts 'Debug sleeping......'
  sleep seconds.to_i
end
