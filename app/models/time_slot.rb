class TimeSlot < ActiveRecord::Base

  named_scope :on_week, lambda { |week_of| {:conditions => ['week_of = ?', week_of]}}
  named_scope :workouts_of_type, lambda { |workout_type| {:conditions => ['workout_type = ?', workout_type]}}
  named_scope :in_time_slot, lambda { |time_slot| {:conditions => ['time_slot = ?', time_slot]}}
  
  validate :check_max_workouts
    
  def check_max_workouts 
    puts "validating time slot"
    time_slots = TimeSlot.on_week(self.week_of).workouts_of_type(self.workout_type).in_time_slot(self.time_slot)
    if (time_slots.size >= max_workouts_for_type(self.workout_type) ) then
      @errors.add_to_base("Max workouts exceeded")
    end
  end
  
  def max_workouts_for_type(workout_type) 
    return 8 if workout_type == "regular"
    return 3 if workout_tpe == "climbing"
  end
    
end
