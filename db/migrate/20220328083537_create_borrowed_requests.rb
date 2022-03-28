class CreateBorrowedRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :borrowed_requests do |t|
      t.integer :status, default: 0
      t.date :borrowed_date
      t.date :returned_date

      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
