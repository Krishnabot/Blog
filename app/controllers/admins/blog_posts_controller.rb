class Admins::BlogPostsController < ProtectedAdminController
  before_action :set_blog_post, only: [:edit, :update, :destroy]
  before_action :set_sidebar_data, only: [:new, :edit]

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post, notice: 'Blog post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: 'Blog post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path, notice: 'Blog post was successfully destroyed.'
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

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