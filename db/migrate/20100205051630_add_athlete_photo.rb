class AddAthletePhoto < ActiveRecord::Migration
  def self.up
     remove_column :athletes, :photo_url
     add_column :athletes, :photo, :string
  end

  def self.down
    remove_column :athletes, :photo
    add_column :athletes, :photo_url, :string
  end
end
