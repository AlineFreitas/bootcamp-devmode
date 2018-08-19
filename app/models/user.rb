class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets


  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name: 'Relationship',
                                  foreign_key: 'followed_id',
                                  dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  

  def follows?(other_user)
    followeds.include?(other_user)
  end

  def follow!(other_user)
    active_relationships.create(followed: other_user)
    # Also works:
    # followed.push other_user
  end

  def unfollow!(followed_user)
    followeds.delete(followed_user)
  end

  def feed
    users_ids = followers.pluck(:id)
    users_ids.push self.id
    Tweet.where(user_id: users_ids).order(created_at: :desc)
  end
end