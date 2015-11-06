class CommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create]

  def create
    @comment = Comment.new(comment_params)
  	@comment.user_id = current_user.id
    if @comment.save
      entry = Entry.find(comment_params[:entry_id])
      flash[:success] = "Comment has been created successfuly"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "There is error during save comment"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :entry_id)
  end
end
