class MediaProfile < ActiveRecord::Base
  mount_uploader :landing, LandingUploader
  named_scope :limited, lambda { |num| { :limit => num } }
  named_scope :reverse_chrono_order, {:order => "created_at desc"} 
end
