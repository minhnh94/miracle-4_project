class Image < ActiveRecord::Base
	validates :title,  presence: true, length: { minimum: 1 }
	validates :file,  presence: true, length: { minimum: 1 }

    mount_uploader :file, ImageUploader

    belongs_to :user
    has_many :image_comment, ->{ order "created_at desc"}
    def self.search(search)
        joins(:user).where("users.name LIKE ? OR title  LIKE ?","%#{search}%", "%#{search}%")
    end
end
