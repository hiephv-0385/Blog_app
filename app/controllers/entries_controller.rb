class EntriesController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def new
  	@entry = Entry.new
  end

  def index
    @entries = Entry.all.paginate(page: params[:page])
  end

  def create
    @entry = current_user.entries.build(entry_params)
  	@entry.created_date = Time.now
  	if @entry.save
      flash[:success] = "Entry created"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @entry = Entry.find(params[:id])
    @comments = @entry.comments.paginate(page: params[:page])
    @commentable = commentable?
    if current_user
      @new_comment = Comment.new
      @new_comment.entry_id = @entry.id
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry updated"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    entry = Entry.find(params[:id])
    if entry
      entry.destroy
      flash[:success] = "Entry deleted"
      redirect_to request.referrer || root_url
    end
  end

  private

  def commentable?
    return current_user && @entry.user && 
            (current_user == @entry.user || current_user.following?(@entry.user))
  end

  def entry_params
      params.require(:entry).permit(:title, :body)
  end

  def comment_params
      params.require(:comment).permit(:content)
  end

end
