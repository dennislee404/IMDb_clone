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

ActiveRecord::Schema[7.0].define(version: 2023_09_23_064746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casts", force: :cascade do |t|
    t.string "name"
    t.string "movie"
    t.string "photo"
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre"
    t.string "movie"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "director"
    t.text "summary"
    t.integer "release_year"
    t.float "ratings"
    t.string "genre"
    t.string "cast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "runtime"
    t.integer "gross"
    t.string "poster"
    t.integer "review_count", default: 100
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.integer "movie_id"
    t.integer "score"
    t.boolean "recommended", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "name"
    t.string "password_digest"
    t.string "avatar", default: "/images/blank-profile-pic.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
