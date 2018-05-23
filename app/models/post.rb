class Post < ApplicationRecord
	belongs_to :category
	mount_uploader :image, ImageUploader
	validates :title, :content, :category_id, :author, presence: true
	
	extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
   slug.blank? || title_changed?
  end

  AUTHOR = {
  	:bk => 'BK',
  	:tk => 'TK',
  	:bktk => 'BK & TK',
    :guest => 'Guest'
  }
end

