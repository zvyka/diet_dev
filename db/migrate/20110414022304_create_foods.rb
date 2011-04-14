class CreateFoods < ActiveRecord::Migration
  def self.up
    create_table :foods do |t|
      t.decimal :added_sugars
      t.decimal :alcohol
      t.decimal :calories
      t.string :name
      t.decimal :dark_green_vegetables
      t.decimal :dry_beans_peas
      t.decimal :factor
      t.decimal :food_id
      t.decimal :fruits
      t.decimal :grains
      t.decimal :increment
      t.decimal :meats
      t.decimal :milk
      t.decimal :multiplier
      t.decimal :oils
      t.decimal :orange_vegetables
      t.decimal :other_vegetables
      t.decimal :portion_amount
      t.decimal :portion_default
      t.string :portion_display_name
      t.decimal :saturated_fats
      t.decimal :solid_fats
      t.decimal :soy
      t.decimal :starchy_vegetables
      t.decimal :vegetables
      t.decimal :whole_grains

      #t.timestamps
    end
  end

  def self.down
    drop_table :foods
  end
end
