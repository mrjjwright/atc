class MediaProfile < ActiveRecord::Base
  mount_uploader :landing, LandingUploader
end
