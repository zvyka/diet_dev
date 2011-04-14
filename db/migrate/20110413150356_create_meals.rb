class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.integer :food_id
      t.integer :serving_size
      t.integer :user_id

      t.timestamps
    end
    add_index :meals, :user_id
  end

  def self.down
    drop_table :meals
  end
end
