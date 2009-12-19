class Workout < ActiveRecord::Base
  
  named_scope :limited, lambda { |num| { :limit => num } }
  
end
