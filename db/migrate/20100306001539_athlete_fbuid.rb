class AthleteFbuid < ActiveRecord::Migration
  def self.up
    add_column :athletes, :fb_uid, :string
  end

  def self.down
    remove_column :athletes, :fb_uid
  end
end
