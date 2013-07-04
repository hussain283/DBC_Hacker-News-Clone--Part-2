class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users

  validates :name, :email, :password, :presence => true
  validates :email, :format => { :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, :message => "Invalid Email" }
  validates :email, uniqueness: { message: "Email already taken!"}
  validates :password, :format => {:with => /^(?=.*\d)(?=.*[a-zA-Z]).{4,8}$/, :message => "Password must be 4-8 chars long and must contain one letter and one number"}, :on => :create
  before_create :encrypt_password

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comment_votes
  has_many :post_votes

  def encrypt_password
    self.password = BCrypt::Password.create(self.password).to_s
  end

  def self.authenticate(email, password)
    User.all.each do |user| 
      if (BCrypt::Password.new(user.password) == password) && (user.email == email)
        return user
      end
    end
    nil
  end
end
