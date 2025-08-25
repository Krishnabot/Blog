class Api::V1::Admin::ArticlesController < Api::BaseController
  before_action :authenticate_admin!
  before_action :set_article, only: [:show, :update, :destroy]

  def index
    scope = Article.order(created_at: :desc)
    scope = scope.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    page = (params[:_page] || 1).to_i
    per  = (params[:_perPage] || 10).to_i
    paged = scope.page(page).per(per)

    start  = (page - 1) * per
    finish = start + paged.size - 1
    response.set_header("Content-Range", "articles #{start}-#{finish}/#{scope.count}")

    render json: AdminArticleSerializer.new(paged).serialize
  end

  def show
    render json: AdminArticleSerializer.new(@article).serialize
  end

  def create
    article = current_admin.articles.new(article_params)
    article.published_at ||= Time.current if article.published?
    if article.save
      render json: AdminArticleSerializer.new(article).serialize, status: :created
    else
      render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    was_published = @article.published?
    if @article.update(article_params)
      if @article.published? && !was_published && @article.published_at.blank?
        @article.update_column(:published_at, Time.current)
      end
      render json: AdminArticleSerializer.new(@article).serialize
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
      :title, :body, :excerpt, :slug, :status, :published_at,
      tags: []
    )
  end
end
