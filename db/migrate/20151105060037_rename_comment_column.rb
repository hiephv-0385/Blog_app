class RenameCommentColumn < ActiveRecord::Migration
  def change
  	rename_column :comments, :poster_id, :user_id
  end
end
