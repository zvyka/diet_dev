desc "Import Dining Services Foods (for the current week)"

task :import_foodpro => :environment do
  require 'mechanize'
  agent = Mechanize.new
  
  page = agent.get('http://isengard.umd.edu/foodpro/')
  
  location_links = page.links_with(:href => /nutframe/)
  
  location_links.each do |l|
    location_page = l.click
    puts "========********USING LOCATION: #{location_page.search("td div b").text.strip} *********========="
    
    date_links = location_page.links_with(:href => /menuSamp/)

    date_links.each do |d|
      date_page = d.click
      
      meal_links = date_page.links_with(:href => /pickMenu/)

      meal_links.each do |m|
        meal_page = m.click
        food_links = meal_page.links_with(:href => /label/)
    
        food_links.each do |f|
          food_page = f.click
          if !food_page.search("font:nth-child(6) b").text.strip.blank?    
            if Food.find_by_name("#{food_page.search("div:nth-child(1) font").text.strip} (UMD)").blank?   
              new_food = Food.create!( :name =>          "#{food_page.search("div:nth-child(1) font").text.strip} (UMD)",
                            :calories =>      food_page.search("font:nth-child(6) b").text.strip[/\d.?\d?/].to_f,
                            :protein =>       food_page.search("tr:nth-child(5) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f,
                            :lipid_total =>   food_page.search("tr:nth-child(2) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :carbohydrates => food_page.search("tr:nth-child(2) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :fiber =>         food_page.search("tr:nth-child(3) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :sugar_total =>   food_page.search("tr:nth-child(4) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :calcium =>       food_page.search("td td td font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :sodium =>        food_page.search("tr:nth-child(6) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :fa_sat =>        food_page.search("tr:nth-child(3) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f, 
                            :cholesterol =>   food_page.search("tr:nth-child(5) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f,
                            :weight_1_gms =>  0, 
                            :weight_1_desc => food_page.search("font:nth-child(4)").text.strip, 
                            :umd => 1)
              puts "************Added: #{food_page.search("div:nth-child(1) font").text.strip} (UMD) as #{new_food.id}"
            else
              puts "Already present: #{food_page.search("div:nth-child(1) font").text.strip} (UMD)" 
            end
          else
            puts "Blank info: #{food_page.search("div:nth-child(1) font").text.strip} (UMD)"              
          end
        end                           
      end
    end
  end
  puts "*******************************Should be rebuilding TS here: (after everything)*******************************"
  Rake::Task["ts:rebuild"].reenable
  Rake::Task["ts:rebuild"].invoke
end