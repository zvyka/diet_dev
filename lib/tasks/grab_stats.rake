desc "grabs stats for today"

task :study_stats => :environment do
  #Getting all experimental users since the beginning
  new_exp_users = User.find_all_by_group_id(1..2)
  
  all_exp_meals = nil
  new_exp_users.each do |user|
    meals = Meal.find_all_by_user_id(user.id)
    if all_exp_meals
      all_exp_meals = all_exp_meals + meals
    else
      all_exp_meals = meals
    end
  end
  
  
  all_exp_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }
  
    days_meals = all_exp_meals.find_all{|item| item.date_eaten <= Date.today}
    puts "On #{Date.today.strftime('%b. %e')}: #{new_exp_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_users.size)} meals per user"
    File.open('/Users/jon/Sites/diet_app/new_stats.txt', 'a+') {|f|
 f.write("\n#{new_exp_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_users.size)},#{Date.today.strftime('%b. %e')}") 
    }
    
     new_exp_1_users = User.find_all_by_group_id(1)

     all_exp_1_meals = nil
     new_exp_1_users.each do |user|
       meals = Meal.find_all_by_user_id(user.id)
       if all_exp_1_meals
         all_exp_1_meals = all_exp_1_meals + meals
       else
         all_exp_1_meals = meals
       end
     end

     all_exp_1_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }
       days_meals = all_exp_1_meals.find_all{|item| item.date_eaten <= Date.today}
       puts "On #{Date.today.strftime('%b. %e')}: #{new_exp_1_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_1_users.size)} meals per user"
       File.open('/Users/jon/Sites/diet_app/new_exp_1_stats.txt', 'a+') {|f|
    f.write("\n#{new_exp_1_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_1_users.size)},#{Date.today.strftime('%b. %e')}") 
       }
     
      new_exp_2_users = User.find_all_by_group_id(2)

      all_exp_2_meals = nil
      new_exp_2_users.each do |user|
        meals = Meal.find_all_by_user_id(user.id)
        if all_exp_2_meals
          all_exp_2_meals = all_exp_2_meals + meals
        else
          all_exp_2_meals = meals
        end
      end

      all_exp_2_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }

        days_meals = all_exp_2_meals.find_all{|item| item.date_eaten <= Date.today}
        puts "On #{Date.today.strftime('%b. %e')}: #{new_exp_2_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_2_users.size)} meals per user"
        File.open('/Users/jon/Sites/diet_app/new_exp_2_stats.txt', 'a+') {|f|
     f.write("\n#{new_exp_2_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_2_users.size)},#{Date.today.strftime('%b. %e')}") 
        }
end

desc "One-time run of stats since start of study: Oct 10, 2011"

task :get_all_study_stats => :environment do
  #Getting all experimental users since the beginning
  puts "All Exp. Users:"
  new_exp_users = User.find_all_by_group_id(1..2)
  
  all_exp_meals = nil
  new_exp_users.each do |user|
    meals = Meal.find_all_by_user_id(user.id)
    if all_exp_meals
      all_exp_meals = all_exp_meals + meals
    else
      all_exp_meals = meals
    end
  end
    
  all_exp_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }
  
  start_date = Date.new(2011, 10, 10)
  (start_date..Date.today).each do |day|
    days_meals = all_exp_meals.find_all{|item| item.date_eaten <= day}
    # @new_m_per_u = "#{@new_m_per_u + "," if !@new_m_per_u.blank?} #{(days_meals.size/days_users).to_f.round(2)}"
    # @new_meals   = "#{@new_meals + "," if !@new_meals.blank?} #{days_meals.size}"
    # @new_users   = "#{@new_users + "," if !@new_users.blank?} '#{days_users}'"
    # @new_dates   = "#{@new_dates + "," if !@new_dates.blank?} '#{day.strftime('%b. %e')}'"
    puts "On #{day.strftime('%b. %e')}: #{new_exp_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_users.size)} meals per user"
    File.open('/Users/jon/Sites/diet_app/new_stats.txt', 'a+') {|f|
 f.write("\n#{new_exp_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_users.size)},#{day.strftime('%b. %e')}") 
    }
  end
  
  puts "All Exp. Group 1 Users"
   new_exp_1_users = User.find_all_by_group_id(1)

   all_exp_1_meals = nil
   new_exp_1_users.each do |user|
     meals = Meal.find_all_by_user_id(user.id)
     if all_exp_1_meals
       all_exp_1_meals = all_exp_1_meals + meals
     else
       all_exp_1_meals = meals
     end
   end

   all_exp_1_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }

   start_date = Date.new(2011, 10, 10)
   (start_date..Date.today).each do |day|
     days_meals = all_exp_1_meals.find_all{|item| item.date_eaten <= day}
     puts "On #{day.strftime('%b. %e')}: #{new_exp_1_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_1_users.size)} meals per user"
     File.open('/Users/jon/Sites/diet_app/new_exp_1_stats.txt', 'a+') {|f|
  f.write("\n#{new_exp_1_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_1_users.size)},#{day.strftime('%b. %e')}") 
     }
   end
   
   puts "All Exp. Group 2 Users"
    new_exp_2_users = User.find_all_by_group_id(2)

    all_exp_2_meals = nil
    new_exp_2_users.each do |user|
      meals = Meal.find_all_by_user_id(user.id)
      if all_exp_2_meals
        all_exp_2_meals = all_exp_2_meals + meals
      else
        all_exp_2_meals = meals
      end
    end

    all_exp_2_meals.sort! { |a,b| a.date_eaten <=> b.date_eaten }

    start_date = Date.new(2011, 10, 10)
    (start_date..Date.today).each do |day|
      days_meals = all_exp_2_meals.find_all{|item| item.date_eaten <= day}
      puts "On #{day.strftime('%b. %e')}: #{new_exp_2_users.size} users,#{days_meals.size} meals,#{(days_meals.size).fdiv (new_exp_2_users.size)} meals per user"
      File.open('/Users/jon/Sites/diet_app/new_exp_2_stats.txt', 'a+') {|f|
   f.write("\n#{new_exp_2_users.size},#{days_meals.size},#{(days_meals.size).fdiv (new_exp_2_users.size)},#{day.strftime('%b. %e')}") 
      }
    end
end

