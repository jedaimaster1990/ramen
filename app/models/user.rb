class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guset
    find_or_create_by!(email: 'guset@guset.com') do |user|
      user.password = password
      user.name = "ゲストユーザー"
    end
  end

  validates :name, presence: true

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post_image
  
  #フォローしたり解除したりするためのアソシエ-ション
  has_many :followings, dependent: :destroy, class_name: 'Relationship', foreign_key: :follower_id
  #フォローした人を参照するアソシエ-ション
  has_many :following_users, through: :followings, source: :followed
  #フォロワーを参照するアソシエ-ション
  has_many :followers, dependent: :destroy, class_name: 'Relationship', foreign_key: :followed_id
  has_many :follower_users, through: :followers, source: :follower

  def favorite(post_image)
    self.favorites.find_or_create_by(post_image: post_image)
  end

  def unfavorite(post_image)
    self.favorites.find_by(post_image: post_image)&.destroy
  end

  def favorite?(post_image)
    self.favorite_posts.include?(post_image)
  end

  def follow(followed)
    self.followings.find_or_create_by(followed: followed)
  end

  def unfollow(followed)
    self.followings.find_by(followed: followed)&.destroy
  end

  def following?(followed)
    self.following_users.include?(followed)
  end
end
