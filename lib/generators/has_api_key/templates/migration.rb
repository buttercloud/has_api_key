# Migration responsible for creating a table to store api keys
class CreateApiKeys < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :api_keys do |t|
      t.belongs_to :authenticatable, :polymorphic => true
      t.string  :token, limit: 255


      t.timestamps
    end

    add_index :api_keys, [:authenticatable_id, :authenticatable_type]
    add_index :api_keys, [:token]
  end
  # Drop table
  def self.down
    drop_table :api_keys
  end
end
