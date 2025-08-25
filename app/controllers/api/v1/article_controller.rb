class Api::V1::ArticlesController < Api::BaseController
  def index
    scope = Article.published_only.recent_first
    scope = scope.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?
    scope = scope.where("? = ANY (tags)", params[:tag])            if params[:tag].present?

    page = (params[:_page] || 1).to_i
    per  = (params[:_perPage] || 10).to_i
    paged = scope.page(page).per(per)

    start  = (page - 1) * per
    finish = start + paged.size - 1
    response.set_header("Content-Range", "articles #{start}-#{finish}/#{scope.count}")

    render json: ArticleSerializer.new(paged).serialize
  end

  def show
    article = Article.published_only.find_by!(slug: params[:slug])
    render json: ArticleSerializer.new(article).serialize
  end
end
