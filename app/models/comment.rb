class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :comment_votes

  validates :content, presence: true

  def score
    self.comment_votes.pluck(:value).inject(:+)
  end
end
