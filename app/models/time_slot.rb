class TimeSlot < ActiveRecord::Base
  named_scope :on_week, lambda { |week_of| {:conditions => ['week_of = ?', week_of]}}
end
