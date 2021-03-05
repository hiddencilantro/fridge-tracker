class CreateTableItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.integer :list_id
    end
  end
end
