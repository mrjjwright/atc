require 'mini_fb'

class Facebook

  NOTE_FQL = "SELECT title, note_id, created_time, updated_time, content FROM note WHERE uid='331358835234'"
  STATUS_FQL = "SELECT message FROM status WHERE uid='331358835234' ORDER BY time DESC"
  FB_API_KEY = "cef99f497bdc50e0097b3110d1a84163"
  FB_SECRET_KEY = "3ce48cc13f682fcf2e5d3b86abf91693"
  FB_SESSION_KEY = "ef6c33c7b46ca92a2bb8d7a4-710381977"
  
  #return statuses
  def statuses()
    #session_key = MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "auth.getSession", "auth_token" => "3RZ7WP")
    return MiniFB.call(FB_API_KEY, FB_SECRET_KEY, "FQL.query", "query" => STATUS_FQL, "session_key" => FB_SESSION_KEY, "expires" => 0)
  end
  
  
end


  