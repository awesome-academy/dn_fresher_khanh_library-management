class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :detail

      t.timestamps

      t.index :name
    end
  end
end
