class ImageComment < ActiveRecord::Base
	before_save
	validates :comment, presence: true, length: { minimum: 1 }

	mount_uploader :file, ImageUploader

	belongs_to :user
	belongs_to :image
	
end
