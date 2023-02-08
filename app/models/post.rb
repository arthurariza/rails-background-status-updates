class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 150 }
  validates :body, presence: true, length: { minimum: 3, maximum: 300 }
end
