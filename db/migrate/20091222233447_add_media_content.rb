class AddMediaContent < ActiveRecord::Migration
  def self.up
    add_column :media_profiles, :content, :text
  end

  def self.down
    remove_column :media_profiles, :content
  end
end
