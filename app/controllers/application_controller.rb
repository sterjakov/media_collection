class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_out_path_for(resource)
    availables_media_collections_path
  end

  def after_sign_in_path_for(resource)
    media_collections_path
  end

  def after_sign_up_path_for(resource)
    media_collections_path
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
