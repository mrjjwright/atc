# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101219060017) do

  create_table "abouts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletes", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "primary_sports"
    t.string   "hometown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.string   "fb_uid"
  end

  create_table "media_profiles", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "landing"
    t.text     "content"
    t.text     "video_embed"
  end

  create_table "time_slots", :force => true do |t|
    t.string   "week_of"
    t.string   "time_slot"
    t.string   "full_name"
    t.string   "workout_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
