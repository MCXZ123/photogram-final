# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :string
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :image, ImageUploader
end
