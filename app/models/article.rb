class Article < ApplicationRecord
		validates :title, :text, presence: true, length: { minimum: 5 }
		has_many :comments, dependent: :destroy 
end
