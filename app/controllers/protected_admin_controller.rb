class ProtectedAdminController < BaseController
  before_action :authenticate_admin!
end