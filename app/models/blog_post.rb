class BlogPost < ApplicationRecord
  belongs_to :admin

  has_one_attached :cover_image

  validates :title, :body, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[draft published] }

  before_validation :ensure_slug
  before_save :compute_reading_time, if: -> { body_changed? && body.present? }
  scope :published, -> { where(status: "published") }
  scope :recent,    -> { order(published_at: :desc).order(created_at: :desc) }

  def ensure_slug
    self.slug = title.to_s.parameterize if slug.blank? && title.present?
  end

  def compute_reading_time
    words = ActionView::Base.full_sanitizer.sanitize(body).split(/\s+/).size
    self.reading_time = [[(words / 200.0).ceil, 1].max, 60].min 
  end
end
