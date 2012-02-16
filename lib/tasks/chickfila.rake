desc "Read Aroon's Chick-fil-a nutrition data"

task :chickfila_foods => :environment do
  #Open file
  filename = '/Users/jon/Sites/diet_app/chick-fil-a.txt'
    
  a = IO.readlines(filename) # reads each line into an array
    
  key = a[2].chomp.split(',') # this splits the line with the key into an array as well, chomp 
                               # removes newlines
    
  a.each { |line|
    
    this_food = line.chomp.split(',')
    
    puts "Reading: #{line}"
    
    food_name = "#{this_food[0]} (ChickFilA)"
    weight_1_desc = this_food[1]
    calories = this_food[2]
    # calories from fat = this_food[3]
    lipid_total = this_food[4]
    fa_sat = this_food[5]
    #trans fat skipped -> this_food[6]
    cholesterol = this_food[7]
    sodium = this_food[8]
    carbohydrates = this_food[9]
    fiber = this_food[10]
    sugar_total = this_food[11]
    protein = this_food[12]
    vit_a = this_food[13]
    vit_c = this_food[14]
    calcium = this_food[15]
    iron = this_food[16]

    
    weight_in_grams = 100
    if weight_1_desc.include? "fl oz" #is it in fluid ounces?
      num_fl_oz = /(\d.\d|\d)/.match(weight_1_desc)[0] #grabs the number of fluid ounces
      weight_in_grams = num_fl_oz.to_f * 29.57 #convert
      #puts "converted from #{num_fl_oz} fl. oz to #{weight_in_grams} grams"
    elsif weight_1_desc.include? "oz" #ok, but is it in ounces?
      num_oz = /(\d.\d|\d)/.match(weight_1_desc)[0] #grabs the number of ounces
      weight_in_grams = num_oz.to_f * 28.35 #convert
      #puts "converted from #{num_oz} oz to #{weight_in_grams} grams"
    elsif weight_1_desc.include? "tbsp" #ok, but is it in ounces?
      num_tbsp = /(\d.\d|\d)/.match(weight_1_desc)[0] #grabs the number of ounces
      weight_in_grams = num_tbsp.to_f * 14.79 #convert
      #puts "converted from #{num_tbsp} tbsp to #{weight_in_grams} grams"
    elsif weight_1_desc.include? "g"
      num_g = /(\d.\d|\d)/.match(weight_1_desc)[0] 
      weight_in_grams = num_g
      #puts "grabbed #{num_g} grams to #{weight_in_grams}"
    end
    
    if calories.to_i == 0
      calories = 0.000001 # the database doesn't allow 0 calories, but this is close enough.
      puts "*******calories changed!"
    end
    
        
    new_food = Food.create!( :name => food_name,
                            :calories =>      calories,
                            :protein =>       protein,
                            :lipid_total =>   lipid_total, 
                            :carbohydrates => carbohydrates, 
                            :fiber =>         fiber, 
                            :sugar_total =>   sugar_total, 
                            :calcium =>       calcium, 
                            :sodium =>        sodium, 
                            :fa_sat =>        fa_sat, 
                            :cholesterol =>   cholesterol,
                            :vit_c =>         vit_c,
                            :vit_a_iu =>      vit_a,
                            :iron =>          iron,
                            :calcium =>       calcium,
                            :weight_1_gms =>  weight_in_grams, 
                            :weight_1_desc => weight_1_desc, 
                            :umd => 2)
               puts "************Added: #{food_name} as #{new_food.id}. 
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
                                weight_1_desc is  #{new_food.weight_1_desc},
                                umd is            #{new_food.umd}"
   }
  
   Rake::Task["ts:rebuild"].reenable
   Rake::Task["ts:rebuild"].invoke
  
end