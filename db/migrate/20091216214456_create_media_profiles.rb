class CreateMediaProfiles < ActiveRecord::Migration
  def self.up
    create_table :media_profiles do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :media_profiles
  end
end
