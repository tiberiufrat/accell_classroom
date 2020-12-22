# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_22_082239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.datetime "time"
    t.bigint "course_id", null: false
    t.bigint "report_id", null: false
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_activities_on_course_id"
    t.index ["report_id"], name: "index_activities_on_report_id"
  end

  create_table "announcements", force: :cascade do |t|
    t.string "classroom_id"
    t.string "text"
    t.integer "materials"
    t.datetime "creation_time"
    t.boolean "all_students"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_announcements_on_course_id"
  end

  create_table "course_work_materials", force: :cascade do |t|
    t.string "classroom_id"
    t.string "title"
    t.string "description"
    t.integer "materials"
    t.datetime "creation_time"
    t.boolean "all_students"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_work_materials_on_course_id"
  end

  create_table "course_works", force: :cascade do |t|
    t.string "classroom_id"
    t.string "title"
    t.string "description"
    t.integer "materials"
    t.datetime "creation_time"
    t.datetime "due_date"
    t.string "work_type"
    t.boolean "all_students"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_works_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "classroom_id"
    t.string "name"
    t.string "section"
    t.string "description"
    t.datetime "creation_time"
    t.string "enrollment_code"
    t.string "course_state"
    t.string "link"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "drive_files", force: :cascade do |t|
    t.string "classroom_id"
    t.string "title"
    t.string "link"
    t.string "thumbnail"
    t.string "drive_fileable_type"
    t.bigint "drive_fileable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["drive_fileable_type", "drive_fileable_id"], name: "index_drive_files_on_drive_fileable"
  end

  create_table "forms", force: :cascade do |t|
    t.string "url"
    t.string "response_url"
    t.string "title"
    t.string "thumbnail"
    t.string "formable_type"
    t.bigint "formable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["formable_type", "formable_id"], name: "index_forms_on_formable"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.string "titile"
    t.string "thumbnail"
    t.string "linkable_type"
    t.bigint "linkable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["linkable_type", "linkable_id"], name: "index_links_on_linkable"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "date_start"
    t.datetime "date_end"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 500, default: "", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.string "classroom_id"
    t.string "title"
    t.string "link"
    t.string "thumbnail"
    t.string "youtube_videoable_type"
    t.bigint "youtube_videoable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["youtube_videoable_type", "youtube_videoable_id"], name: "index_youtube_videos_on_youtube_videoable"
  end

  add_foreign_key "activities", "courses"
  add_foreign_key "activities", "reports"
  add_foreign_key "announcements", "courses"
  add_foreign_key "course_work_materials", "courses"
  add_foreign_key "course_works", "courses"
  add_foreign_key "courses", "users"
  add_foreign_key "reports", "users"
end
