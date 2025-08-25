class ArticleSerializer
  include Alba::Resource

  attributes :title, :slug, :excerpt, :status, :published_at, :reading_time, :tags, :body

  attribute :cover_image_url do |article|
    if article.cover_image.attached?
      Rails.application.routes.url_helpers.url_for(article.cover_image)
    end
  end
end
