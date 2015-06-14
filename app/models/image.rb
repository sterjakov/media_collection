class Image < ActiveRecord::Base

  belongs_to :media_collection
  mount_uploader :image, ImageUploader

end
