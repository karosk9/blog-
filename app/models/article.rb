class Article < ApplicationRecord
		validates :title, :text, presence: true, length: { minimum: 5 }
		has_many :comments, dependent: :destroy
		belongs_to :user

		def tag=(text)
			text.is_a?(String) ? super(sanitize_tags(text)) : super(text)
# jeśli text jest stringiem wywołuje metodę sanitize tags która zmienia string na array, jeśli nie jest stringiem nie wykona się
		end

		private

		def sanitize_tags(text)
			text.split(" ").map(&:downcase).uniq
		end
end
