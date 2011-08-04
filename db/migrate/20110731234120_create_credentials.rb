class CreateCredentials < ActiveRecord::Migration
  def self.up
    create_table :credentials do |t|
      t.string :consumer_key
      t.string :shared_secret

      t.timestamps
    end
  end

  def self.down
    drop_table :credentials
  end
end
