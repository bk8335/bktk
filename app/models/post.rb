class Post < ApplicationRecord
	belongs_to :category
	mount_uploader :image, ImageUploader
	validates :title, :content, :category_id, :author, presence: true
  before_save :calculate_wordcount
	
	extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  AUTHOR = {
    :bk => 'BK',
    :tk => 'TK',
    :bktk => 'BK & TK',
    :guest => 'Guest'
  }

  WORDS_PER_MINUTE = 265.0

  def should_generate_new_friendly_id?
   slug.blank? || title_changed?
  end

  def calculate_wordcount
    self.wordcount = self.content.split.size
  end

  def reading_time
    # wordcount = 1 if wordcount.nil?
    reading_time = (wordcount / 265.0).round
    reading_time < 1 ? "<1" : reading_time
  end
end

