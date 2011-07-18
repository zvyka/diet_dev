class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.integer :meal_id
      t.integer :food_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
