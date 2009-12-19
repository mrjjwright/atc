require 'mini_fb'

class Facebook

  NOTE_FQL = "SELECT title, note_id, created_time, updated_time, content FROM note WHERE uid='331358835234' AND updated_time > "
  STATUS_FQL = "SELECT message FROM status WHERE uid='331358835234' ORDER BY time DESC"
  FB_API_KEY = "cef99f497bdc50e0097b3110d1a84163"
  FB_SECRET_KEY = "3ce48cc13f682fcf2e5d3b86abf91693"
  FB_SESSION_KEY = "ef6c33c7b46ca92a2bb8d7a4-710381977"
  
  #return statuses
  def statuses()
    #session_key = MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "auth.getSession", "auth_token" => "3RZ7WP")
    return MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => STATUS_FQL, "session_key" => FB_SESSION_KEY, "expires" => 0)
  end
  
  def sync_workouts()
    query = NOTE_FQL + Workout.first.updated_at.to_i.to_s
    p "Executing #{NOTE_FQL}"
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


  