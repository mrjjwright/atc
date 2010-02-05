class Athlete < ActiveRecord::Base
  mount_uploader :photo, AthletePhotoUploader
end
