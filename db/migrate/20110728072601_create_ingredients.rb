class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.integer :meal_id
      t.integer :what_food

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
