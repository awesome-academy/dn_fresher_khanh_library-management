class ChangeUserToAuthorInBooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :books, :user, foreign_key: true
    remove_index :books, name: "index_books_on_name_and_user_id"

    add_reference :books, :author, foreign_key: true
    add_index :books, %i[name author_id]
  end
end
