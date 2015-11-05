class StaticPagesController < ApplicationController
  def home
  	@entries = Entry.all.paginate(page: params[:page])
  end
end
