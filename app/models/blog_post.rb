class BlogPost < ApplicationRecord
  enum status: { draft: "draft", published: "published" }

  belongs_to :admin
  has_one_attached :cover_image 

  validates :title, :body, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :ensure_slug

  scope :published_only, -> { where(status: :published) }
  scope :recent_first,   -> { order(published_at: :desc, created_at: :desc) }

  private

  def ensure_slug
    return if slug.present?
    base = title.to_s.parameterize
    s = base
    i = 1
    while self.class.exists?(slug: s)
      i += 1
      s = "#{base}-#{i}"
    end
    self.slug = s
  end
end
