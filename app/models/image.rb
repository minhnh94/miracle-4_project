class Image < ActiveRecord::Base
    mount_uploader :file, ImageUploader
    
    belongs_to :user
    has_many :image_comment, ->{ order "created_at ASC"}
    def self.search(search)
        where("title LIKE ?", "%#{search}%")
    end    
end
