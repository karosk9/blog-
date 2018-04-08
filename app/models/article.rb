class Article < ApplicationRecord
		include Intro
		before_validation :filter_profanity_words
		validates :title, :text, presence: true, length: { minimum: 5 }
		has_many :comments, dependent: :destroy
		has_many :likes
		belongs_to :user
		after_destroy :send_destroy_info

		def tag=(text)
			text.is_a?(String) ? super(sanitize_tags(text)) : super(text)
# jeśli text jest stringiem wywołuje metodę sanitize tags która zmienia string na array, jeśli nie jest stringiem nie wykona się
		end

		private
		def send_destroy_info
				ArticleMailer.article_destroy_info(self).deliver
		end

		def sanitize_tags(text)
			text.split(" ").map(&:downcase).uniq
		end

		def filter_profanity_words
			self.text = ProfanityFilter.new(self.text).censored_text
		end
end
