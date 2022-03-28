class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :content

      t.timestamps

      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.index %i[user_id book_id]
    end
  end
end
