class Admins::DashboardController < Admins::ProtectedAdminController
  skip_before_action :authenticate_admin!, only: [:redirect_based_on_auth]

  def index
    @blog_posts = BlogPost.where(admin_id: current_admin.id).order(created_at: :desc)
  end

  def redirect_based_on_auth
    if admin_signed_in?
      redirect_to admin_dashboard_path
    else
      redirect_to new_admin_session_path
    end
  end
end