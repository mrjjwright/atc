class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.string :week_of
      t.string :time_slot
      t.string :full_name
      t.string :workout_type

      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
  end
end
