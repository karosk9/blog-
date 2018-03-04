class Article < ApplicationRecord
		validates :title, :text, presence: true, length: { minimum: 5 }
		has_many :comments, dependent: :destroy
		has_many :likes
		belongs_to :user

		has_attached_file :image, default_url: "/images/:style/missing.png"
		validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

		def tag=(text)
			text.is_a?(String) ? super(sanitize_tags(text)) : super(text)
# jeśli text jest stringiem wywołuje metodę sanitize tags która zmienia string na array, jeśli nie jest stringiem nie wykona się
		end

		private

		def sanitize_tags(text)
			text.split(" ").map(&:downcase).uniq
		end
end
