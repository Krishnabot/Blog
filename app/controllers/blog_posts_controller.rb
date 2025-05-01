class BlogPostsController < BaseController
  before_action :set_blog_post, only: [:show]
  before_action :set_sidebar_data, only: [:index, :show]

  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Blog post not found.'
  end

  def set_sidebar_data
    @posts_by_year = BlogPost.order(created_at: :desc).group_by { |post| post.created_at.year }
    @posts_by_year.transform_values! do |posts|
      posts.group_by { |post| post.created_at.strftime('%B') }.transform_values! do |month_posts|
        month_posts.group_by { |p| p.created_at.strftime('Week %U') }
      end
    end
  end
end