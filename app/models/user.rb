class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validates :name,
    uniqueness: true,
    length: { minimum: 2, maximum: 20 }

  validates :introduction,
    length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :relationships, class_name:"relationship", foregin_key:"follower_id", dependent: :destroy
  has_many :relationshipss, class_name:"relationship", foregin_key:"followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :relationshipss, source: :follower

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  def follow(user_id)
    relationships.create(follwed_id: user_id)
  end

  def unfollow(uesr_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


end
