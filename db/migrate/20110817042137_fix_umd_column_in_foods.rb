class FixUmdColumnInFoods < ActiveRecord::Migration
  def self.up
      remove_column :foods, :umd
      add_column :foods, :umd, :integer, :default => 0
    end

    def self.down
      remove_column :foods, :umd
    end
end
