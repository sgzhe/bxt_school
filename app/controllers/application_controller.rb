class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  def paginate(resource)
    resource.page(params[:page]).per(params[:pre])
  end

  def paginate_meta(resource)
    { current_page: resource.current_page,
      current_per_page: resource.limit_value,
      next_page: resource.next_page,
      prev_page: resource.prev_page,
      total_pages: resource.total_pages,
      total_count: resource.total_count }
  end

  def base_url
    "#{request.protocol}#{request.host_with_port}"
  end

  helper_method :paginate_meta, :base_url

  private
  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end


end
