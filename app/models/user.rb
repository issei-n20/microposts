class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  validates :body, presence: true, length: { maximum: 140 }, on: :update
  
  has_secure_password
  has_many :microposts
  
  # 中間テーブル
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  
  has_many :following_users, through: :following_relationships, source: :followed
  
  # 中間テーブル
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # 中間テーブル
  has_many :likes,      class_name: "Like",
                        foreign_key: "micropost_id",
                        dependent: :destroy
  has_many :like_microposts, through: :likes, source: :micropost
  
  # 他のユーザーをフォローする
  def follow(other_user)
    # 
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # つぶやきを取得するメソッド
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  # お気に入りに追加
  def like(micropost)
    
    like.create(micropost_id: micropost.id)
  end
  
end
