class Entry < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }


  validates :title,  presence: true, length: { maximum: 150 }
  validates :body,  presence: true, length: { maximum: 400 }

end
