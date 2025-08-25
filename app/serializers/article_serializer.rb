
class ArticleSerializer
  include Alba::Resource

  attributes :title, :slug, :excerpt, :status, :published_at

  attribute :body do |article|

    article.body
  end


  attribute :cover_image_url do |article|
    if article.cover_image.attached?
      Rails.application.routes.url_helpers.url_for(article.cover_image)
    end
  end
end
