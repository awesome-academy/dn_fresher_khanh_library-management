class CreateBookRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :book_requests do |t|
      t.integer :status, default: 0
      t.integer :amount

      t.timestamps

      t.references :book, foreign_key: true
      t.references :borrowed_request, foreign_key: true
    end
  end
end
