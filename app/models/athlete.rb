class Athlete < ActiveRecord::Base
  mount_uploader :photo, AthletePhotoUploader
  
  def check_for_fb_uid
    unless self.fb_uid? then
      f = Facebook.new
      self.fb_uid = f.uid_for_group_user(self.name)
      self.save
    end
  end
end
