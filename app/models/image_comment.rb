class ImageComment < ActiveRecord::Base
	before_save
	validates :comment, presence: true, length: { minimum: 6 }

	mount_uploader :file, ImageUploader

	belongs_to :user
	
end
