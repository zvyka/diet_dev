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
          page_food_name = "#{food_page.search("div:nth-child(1) font").text.strip} (UMD)"
          
          if !food_page.search("font:nth-child(6) b").text.strip.blank?
            db_food = Food.find_by_name(page_food_name)
            
            page_calories = food_page.search("font:nth-child(6) b").text.strip[/\d.?\d?/].to_f
            page_protein = food_page.search("tr:nth-child(5) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_lipid_total =  food_page.search("tr:nth-child(2) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_carbohydrates = food_page.search("tr:nth-child(2) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_fiber = food_page.search("tr:nth-child(3) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_sugar_total = food_page.search("tr:nth-child(4) td:nth-child(3) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_calcium = food_page.search("td td td font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_sodium = food_page.search("tr:nth-child(6) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_fa_sat = food_page.search("tr:nth-child(3) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_cholesterol = food_page.search("tr:nth-child(5) td:nth-child(1) font:nth-child(2)").text.strip[/\d.?\d?/].to_f
            page_weight_1_desc = food_page.search("font:nth-child(4)").text.strip
            
            if db_food.blank?   
              new_food = Food.create!( :name => page_food_name,
                            :calories =>      page_calories,
                            :protein =>       page_protein,
                            :lipid_total =>   page_lipid_total, 
                            :carbohydrates => page_carbohydrates, 
                            :fiber =>         page_fiber, 
                            :sugar_total =>   page_sugar_total, 
                            :calcium =>       page_calcium, 
                            :sodium =>        page_sodium, 
                            :fa_sat =>        page_fa_sat, 
                            :cholesterol =>   page_cholesterol,
                            :weight_1_gms =>  100, 
                            :weight_1_desc => page_weight_1_desc, 
                            :umd => 1)
              puts "************Added: #{page_food_name} as #{new_food.id}. 
                                Calories is       #{new_food.calories}, 
                                protein is        #{new_food.protein}, 
                                lipid_total is    #{new_food.lipid_total}, 
                                carbohydrates is  #{new_food.carbohydrates}, 
                                fiber is          #{new_food.fiber}, 
                                sugar_total is    #{new_food.sugar_total}, 
                                calcium is        #{new_food.calcium}, 
                                sodium is         #{new_food.sodium}, 
                                fa_sat is         #{new_food.fa_sat}, 
                                cholesterol is    #{new_food.cholesterol}, 
                                weight_1_desc is  #{new_food.weight_1_desc}"
            else
              puts "Already present: #{page_food_name} as #{db_food.id}. 
                    Calories is #{db_food.calories} vs #{page_calories}, 
                    protein is #{db_food.protein} vs #{page_protein}, 
                    lipid_total is #{db_food.lipid_total} vs #{page_lipid_total}, 
                    carbohydrates is #{db_food.carbohydrates} vs #{page_carbohydrates}, 
                    fiber is #{db_food.fiber} vs #{page_fiber}, 
                    sugar_total is #{db_food.sugar_total} vs #{page_sugar_total}, 
                    calcium is #{db_food.calcium} vs #{page_calcium}, 
                    sodium is #{db_food.sodium} vs #{page_sodium}, 
                    fa_sat is #{db_food.fa_sat} vs #{page_fa_sat}, 
                    cholesterol is #{db_food.cholesterol} vs  #{page_cholesterol}, 
                    weight_1_desc is #{db_food.weight_1_desc} vs #{page_weight_1_desc}" 
              if db_food.calories != page_calories
                puts "*************Changing calories from #{db_food.calories} to #{page_calories}"
                db_food.update_attributes(:calories => page_calories)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.protein != page_protein
                db_food.update_attributes(:protein => page_protein)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.lipid_total != page_lipid_total
                puts "Changing lipid_total from #{db_food.lipid_total} to #{page_lipid_total}"
                db_food.update_attributes(:lipid_total => page_lipid_total)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.carbohydrates != page_carbohydrates
                puts "Changing carbohydrates from #{db_food.carbohydrates} to #{page_carbohydrates}"
                db_food.update_attributes(:carbohydrates => page_carbohydrates)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.fiber != page_fiber
                puts "Changing fiber from #{db_food.fiber} to #{page_fiber}"
                db_food.update_attributes(:fiber => page_fiber)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.sugar_total != page_sugar_total
                puts "Changing sugar_total from #{db_food.sugar_total} to #{page_sugar_total}"
                db_food.update_attributes(:sugar_total => page_sugar_total)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.calcium != page_calcium
                puts "Changing calcium from #{db_food.calcium} to #{page_calcium}"
                db_food.update_attributes(:calcium => page_calcium)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.sodium != page_sodium
                puts "Changing sodium from #{db_food.sodium} to #{page_sodium}"
                db_food.update_attributes(:sodium => page_sodium)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.fa_sat != page_fa_sat
                puts "Changing fa_sat from #{db_food.fa_sat} to #{page_fa_sat}"
                db_food.update_attributes(:fa_sat => page_fa_sat)
                puts "Changing fa_sat from #{db_food.fa_sat} to #{page_fa_sat}"
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.cholesterol != page_cholesterol
                puts "Changing cholesterol from #{db_food.cholesterol} to #{page_cholesterol}"                
                db_food.update_attributes(:cholesterol => page_cholesterol)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end
              if db_food.weight_1_desc != page_weight_1_desc
                puts "Changing weight_1_desc from #{db_food.weight_1_desc} to #{page_weight_1_desc}"
                db_food.update_attributes(:weight_1_desc => page_weight_1_desc)
                puts "************Updated: #{page_food_name} (#{db_food.id}). 
                                  Calories is       #{db_food.calories}, 
                                  protein is        #{db_food.protein}, 
                                  lipid_total is    #{db_food.lipid_total}, 
                                  carbohydrates is  #{db_food.carbohydrates}, 
                                  fiber is          #{db_food.fiber}, 
                                  sugar_total is    #{db_food.sugar_total}, 
                                  calcium is        #{db_food.calcium}, 
                                  sodium is         #{db_food.sodium}, 
                                  fa_sat is         #{db_food.fa_sat}, 
                                  cholesterol is    #{db_food.cholesterol}, 
                                  weight_1_desc is  #{db_food.weight_1_desc}"
              end                            
            end
          else
            puts "Blank info: #{page_food_name}"              
          end
        end                           
      end
    end
  end
  puts "*******************************Should be rebuilding TS here: (after everything)*******************************"
  Rake::Task["ts:rebuild"].reenable
  Rake::Task["ts:rebuild"].invoke
end