class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.text :detail
      t.bigint :amount

      t.timestamps

      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.references :publisher, foreign_key: true

      t.index %i[name user_id]
    end
  end
end
