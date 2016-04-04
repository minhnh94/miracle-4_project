class ImageComment < ActiveRecord::Base
	mount_uploader :file, ImageUploader

	belongs_to :user
	
end
