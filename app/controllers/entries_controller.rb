class EntriesController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]

  def new
  	@entry = Entry.new
  end

  def index
    @entries = Entry.paginate(page: params[:page])
  end

  def create
    @entry = current_user.entries.build(entry_params)
  	@entry.created_date = Time.now
  	if @entry.save
      flash[:success] = "Entry created"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
  end

  private

  def entry_params
      params.require(:entry).permit(:title, :body)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
