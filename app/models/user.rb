class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets


  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :followers, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name: 'Relationship',
                                  foreign_key: 'followed_id',
                                  dependent: :destroy
  has_many :followeds, through: :passive_relationships, source: :follower
  



  def follow(followed_user)
    unless followed_user.followers.include?(self)
      followed_user.following(current_user)
    end
  end
end