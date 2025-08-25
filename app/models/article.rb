class Article < ApplicationRecord
  enum status: { draft: "draft", published: "published" }

  belongs_to :admin
  has_one_attached :cover_image

  validates :title, :body, :slug, :status, presence: true
  validates :slug, uniqueness: true

  scope :published_only, -> { where(status: :published) }
  scope :recent_first,   -> { order(published_at: :desc, created_at: :desc) }

  before_validation :ensure_slug
  before_save :compute_reading_time

  private

  def ensure_slug
    return if slug.present?
    base = title.to_s.parameterize
    candidate = base
    i = 1
    while self.class.exists?(slug: candidate)
      i += 1
      candidate = "#{base}-#{i}"
    end
    self.slug = candidate
  end

  def compute_reading_time
    words = body.to_s.scan(/\w+/).size
    self.reading_time = (words / 200.0).ceil
  end
end
