class Entry < ActiveRecord::Base

	belongs_to :user
	default_scope -> { order(created_date: :desc) }

	validates :title,  presence: true, length: { maximum: 150 }
	validates :body,  presence: true, length: { maximum: 200 }

end
