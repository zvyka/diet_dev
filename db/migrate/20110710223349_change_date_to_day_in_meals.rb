class ChangeDateToDayInMeals < ActiveRecord::Migration
  def self.up
    rename_column :meals, :date, :day
  end

  def self.down
    rename_column :meals, :day, :date
  end
end
