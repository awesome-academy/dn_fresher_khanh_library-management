class CreatePublishers < ActiveRecord::Migration[6.1]
  def change
    create_table :publishers do |t|
      t.string :name

      t.timestamps

      t.index :name
    end
  end
end
