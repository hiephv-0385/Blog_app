class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :body
      t.datetime :created_date

      t.timestamps null: false
    end
  end
end
