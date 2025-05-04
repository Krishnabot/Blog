class Admins::ProtectedAdminController < BaseController
  before_action :authenticate_admin!
end
