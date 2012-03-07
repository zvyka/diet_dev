desc "Read Aroon's participant data"

task :add_participants => :environment do
  
  require "faster_csv"

  counter = 0
  FasterCSV.foreach("/Users/jon/Sites/participant_data_spring12_2.csv", 
                    :headers           => true,
                    :header_converters => :symbol) do |row|
      counter = counter +1
      line = row.to_hash
      puts "Participant #{counter}:\nname: #{line[:name]}\nemail: #{line[:email]}\ngrad_year: #{line[:grad_year]}\nbirth_year: #{line[:birth_year]}\nid_num: #{line[:id_num]}\nis_male: #{line[:is_male]}\nheight: #{line[:height]}\nweight: #{line[:weight]}\nis_special: #{line[:is_special]}\ngroup_id: #{line[:group_id]}\n\n"
      User.create!(:name => line[:name],
                   :email => line[:email],
                   :grad_year => line[:grad_year].to_i,
                   :birth_year => line[:birth_year].to_i,
                   :UID => "blank_#{counter}",
                   :is_male => line[:is_male],
                   :height => line[:height].to_i,
                   :is_special => line[:is_special],
                   :group_id => line[:group_id].to_i,
                   :id_num => line[:id_num].to_i,
                   :weight => line[:weight].to_i)
    end
    
end