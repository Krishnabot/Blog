class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :admin
end