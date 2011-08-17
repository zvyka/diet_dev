desc "Import Dining Services Foods (for the current week)"

task :import_foodpro => :environment do
  require 'mechanize'
  agent = Mechanize.new
  
  page = agent.get('http://isengard.umd.edu/foodpro/nutframe.asp?locationNum=04&naFlag=1')

  date_links = page.links_with(:href => /menuSamp/)

  date_links.each do |d|
    date_page = d.click
    meal_links = date_page.links_with(:href => /pickMenu/)

    meal_links.each do |m|
      meal_page = m.click
      food_links = meal_page.links_with(:href => /label/)
    
      food_links.each do |f|
        food_page = f.click
        if !food_page.search("font:nth-child(6) b").text.strip.blank?        
          Food.create!( :name =>          "#{food_page.search("div:nth-child(1) font").text.strip} (UMD)",
                        :calories =>      food_page.search("font:nth-child(6) b").text.strip[/[0-9]+.?[0-9]+/].to_f,
                        :protein =>       food_page.search("tr:nth-child(5) td:nth-child(3) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f,
                        :lipid_total =>   food_page.search("tr:nth-child(2) td:nth-child(1) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :carbohydrates => food_page.search("tr:nth-child(2) td:nth-child(3) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :fiber =>         food_page.search("tr:nth-child(3) td:nth-child(3) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :sugar_total =>   food_page.search("tr:nth-child(4) td:nth-child(3) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :calcium =>       food_page.search("td td td font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :sodium =>        food_page.search("tr:nth-child(6) td:nth-child(1) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :fa_sat =>        food_page.search("tr:nth-child(3) td:nth-child(1) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f, 
                        :cholesterol =>   food_page.search("tr:nth-child(5) td:nth-child(1) font:nth-child(2)").text.strip[/[0-9]+.?[0-9]+/].to_f,
                        :weight_1_gms =>  0, 
                        :weight_1_desc => food_page.search("font:nth-child(4)").text.strip, 
                        :umd => 1)
        end
      end                           
    end
  end
end