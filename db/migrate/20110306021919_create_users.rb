class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :grad_year
      t.integer :birth_year
      t.integer :UID
      t.boolean :is_male
      t.integer :height
      t.boolean :is_special

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
