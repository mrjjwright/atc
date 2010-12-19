class AddVideo < ActiveRecord::Migration
  def self.up
    add_column :media_profiles, :video_embed, :text
  end

  def self.down
    remove_column :media_profiles, :video_embed
  end
end
