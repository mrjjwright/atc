require 'mini_fb'

class Facebook

  NOTE_FQL = "SELECT title, note_id, created_time, updated_time, content FROM note WHERE uid='331358835234' "
  STATUS_FQL = "SELECT message FROM status WHERE uid='331358835234' ORDER BY time DESC"
  FB_API_KEY = "cef99f497bdc50e0097b3110d1a84163"
  FB_SECRET_KEY = "3ce48cc13f682fcf2e5d3b86abf91693"
  FB_SESSION_KEY = "63b6568c7209415fbba35d08-710381977"
  ATC_GID = "331358835234"
  
  
  def session_key()
    p MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "auth.getSession", "auth_token" => "5B1DUL")
  end
    
  #return statuses
  def statuses()
    #session_key = MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "auth.getSession", "auth_token" => "3RZ7WP")
    return MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => STATUS_FQL, "session_key" => FB_SESSION_KEY, "expires" => 0)
  end
  
  # search for photos tagged for a particular user
  def photos_tagged_user(uid)
    query = "select pid, src_big, src_small from photo where pid in (select pid from photo_tag where subject = #{uid}) and owner=#{ATC_GID} order by created"
    return MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => query, "session_key" => FB_SESSION_KEY, "expires" => 0)
  end
  
  # given a common name for a member looks up that member in the ATC
  def uid_for_group_user(group_user)
    query = "select uid, first_name, last_name from user where uid in (SELECT uid FROM group_member WHERE gid=331358835234)"
    users_in_atc = MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => query, "session_key" => FB_SESSION_KEY, "expires" => 0)
    user = users_in_atc.detect(){|user| "#{user["first_name"]} #{user["last_name"]}".include?(group_user) }
    return user["uid"] unless user.nil?
    return nil
  end

  # search for photos for a workout and if they exist import them
  def photos_for_workout(workout)
    query = "SELECT pid FROM photo WHERE aid IN ( SELECT aid FROM album WHERE name='#{workout}' and owner=331358835234 ) ORDER BY created"
    p MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => query, "session_key" => FB_SESSION_KEY, "expires" => 0)
  end
  
  def sync_workouts()
    query = NOTE_FQL
    last_ts = Workout.first.updated_at.to_i.to_s unless Workout.first.nil?
    unless last_ts.nil?
      query = query + " AND updated_time > " + last_ts
    end
    p "Executing #{query}"
    workouts = MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => query, "session_key" => FB_SESSION_KEY, "expires" => 0)
    num_imported = 0
    workouts.each {|workout|
      #make sure this workout doesn't exist'
      next unless Workout.find_by_external_id(workout["note_id"]).nil?
      w = Workout.new
      w.content = workout["content"]
      w.created_at = Time.at(workout["created_time"])
      w.updated_at = Time.at(workout["updated_time"])
      w.external_id = workout["note_id"]
      w.name = workout["title"]
      w.save
      num_imported = num_imported + 1
    }
    p "Imported #{num_imported} workouts from FB into database"
  end
  
  
end


  