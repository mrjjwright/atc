class CreateAthletes < ActiveRecord::Migration
  def self.up
    create_table :athletes do |t|
      t.string :name
      t.text :content
      t.string :photo_url
      t.string :primary_sports
      t.string :hometown

      t.timestamps
    end
  end

  def self.down
    drop_table :athletes
  end
end
