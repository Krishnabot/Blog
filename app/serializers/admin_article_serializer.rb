
class AdminArticleSerializer
  include Alba::Resource

  attributes :id, :title, :slug, :excerpt, :status, :published_at, :created_at, :updated_at, :body

  attribute :author_email do |article|
    article.admin.email
  end

  attribute :cover_image_url do |article|
    if article.cover_image.attached?
      Rails.application.routes.url_helpers.url_for(article.cover_image)
    end
  end
end
