class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    inform = %i(name email password password_confirmation)
    devise_parameter_sanitizer.permit :sign_up, keys: inform
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
