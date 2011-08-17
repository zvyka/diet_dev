class AddUmdColumnToFoods < ActiveRecord::Migration
  def self.up
      add_column :foods, :umd, :integer
    end

    def self.down
      remove_column :foods, :umd
    end
end
