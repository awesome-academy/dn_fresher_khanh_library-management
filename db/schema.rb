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

ActiveRecord::Schema.define(version: 2022_03_28_084630) do

  create_table "authors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "book_requests", charset: "utf8mb4", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "book_id"
    t.bigint "borrowed_request_id"
    t.index ["book_id"], name: "index_book_requests_on_book_id"
    t.index ["borrowed_request_id"], name: "index_book_requests_on_borrowed_request_id"
  end

  create_table "books", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.bigint "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "publisher_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["name", "user_id"], name: "index_books_on_name_and_user_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "borrowed_requests", charset: "utf8mb4", force: :cascade do |t|
    t.integer "status", default: 0
    t.date "borrowed_date"
    t.date "returned_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_borrowed_requests_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "publishers", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_publishers_on_name"
  end

  create_table "reactions", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_reactions_on_book_id"
    t.index ["user_id", "book_id"], name: "index_reactions_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "reviews", charset: "utf8mb4", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id", "book_id"], name: "index_reviews_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "book_requests", "books"
  add_foreign_key "book_requests", "borrowed_requests"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "publishers"
  add_foreign_key "books", "users"
  add_foreign_key "borrowed_requests", "users"
  add_foreign_key "reactions", "books"
  add_foreign_key "reactions", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
