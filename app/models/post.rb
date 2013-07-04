class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_votes

  validates :title, presence: true

  after_create :check_url

  def check_url
    self.url = "/posts/#{self.id}/show" if self.url.blank?
    self.save
  end

  def score
    self.post_votes.pluck(:value).inject(:+)
  end

  def can_vote? (user)
    self.post_votes.where(user_id: user.id).blank?
  end
end
