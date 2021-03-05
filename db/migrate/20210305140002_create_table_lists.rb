class CreateTableLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.date :date
      t.integer :user_id
    end
  end
end
