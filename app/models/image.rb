class Image < ActiveRecord::Base
	validates :title,  presence: true, length: { minimum: 1 }
	validates :file,  presence: true, length: { minimum: 1 }

    mount_uploader :file, ImageUploader
    
    belongs_to :user
    has_many :image_comment, ->{ order "created_at desc"}
    def self.search(search)
        where("title  LIKE ?", "%#{search}%")
    end    
end
