class AddColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :poster_id, :integer
    add_column :comments, :entry_id, :integer
  end
end
