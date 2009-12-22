class AddFileCol < ActiveRecord::Migration
  def self.up
    add_column :media_profiles, :landing, :string
  end

  def self.down
     remove_column :media_profiles, :landing
  end
end
