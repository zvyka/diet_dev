class ChangeDayToDateEatenInMeals < ActiveRecord::Migration
  def self.up
    rename_column :meals, :day, :date_eaten
  end

  def self.down
    rename_column :meals, :date_eaten, :day
  end
end
