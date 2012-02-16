desc "Grab current trackings statistics and write them to a file."

task :get_tracker_stats => :environment do
  num_users = User.all.size
  num_meals = Meal.all.size
  
  meals_per_user = num_meals.fdiv num_users
  
  timestamp = Time.now
  
  stats = "\n#{num_users},#{num_meals},#{meals_per_user},#{timestamp}"
  
  puts "Overall - #{stats}"
  
  File.open('/Users/jon/Sites/diet_app/stats.txt', 'a+') {|f| f.write(stats) }
  
  exp_1_num_users = 0
  exp_1_num_meals = 0
  User.find_all_by_group_id(1).each do |u1|
    exp_1_num_users = exp_1_num_users + 1
    Meal.find_all_by_user_id(u1.id).each do |m|
      exp_1_num_meals = exp_1_num_meals + 1
    end
  end
  
  exp_1_meals_per_user = exp_1_num_meals.fdiv exp_1_num_users
  exp_1_stats = "\n#{exp_1_num_users},#{exp_1_num_meals},#{exp_1_meals_per_user},#{timestamp}"  
  
  puts "Exp.1 - #{exp_1_stats}"
  File.open('/Users/jon/Sites/diet_app/exp_1_stats.txt', 'a+') {|f| f.write(exp_1_stats) }
  
  exp_2_num_users = 0
  exp_2_num_meals = 0
  User.find_all_by_group_id(2).each do |u2|
    exp_2_num_users = exp_2_num_users + 1
    Meal.find_all_by_user_id(u2.id).each do |m|
      exp_2_num_meals = exp_2_num_meals + 1
    end
  end
  
  exp_2_meals_per_user = exp_2_num_meals.fdiv exp_2_num_users
  exp_2_stats = "\n#{exp_2_num_users},#{exp_2_num_meals},#{exp_2_meals_per_user},#{timestamp}"  
  
  puts "Exp.2 - #{exp_2_stats}"
  File.open('/Users/jon/Sites/diet_app/exp_2_stats.txt', 'a+') {|f| f.write(exp_2_stats) }
  
  exp_num_users = exp_1_num_users + exp_2_num_users
  exp_num_meals = exp_1_num_meals + exp_2_num_meals
  
  exp_meals_per_user = exp_num_meals.fdiv exp_num_users  
  exp_stats = "\n#{exp_num_users},#{exp_num_meals},#{exp_meals_per_user},#{timestamp}"
  
  puts "Full Exp - #{exp_stats}"
  
  File.open('/Users/jon/Sites/diet_app/exp_stats.txt', 'a+') {|f| f.write(exp_stats) }
  
end