class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  def set_locale
    #session[:locale] = "th"
    I18n.locale = params[:locale] || I18n.default_locale
  end
  #def set_locale
    #locale = params[:locale] || I18n.default_locale
    #I18n.locale = Spree::Frontend::Config[:locale]
  #end
  #def after_sign_out_path_for(resource_or_scope)
  #  URI.parse(request.referer).path if request.referer
  #end
  
  protected  
      #def after_sign_out_path_for(resource_or_scope)
        #URI.parse(request.referer).path if request.referer
      #end
      def after_sign_in_path_for(resource)
      isamdin = false
      Spree::Role.where(admin_accessible: true).find_each do |role|
        isamdin ||= resource.has_spree_role?(role.name)
      end
      if isamdin
        admin_path
      else
        root_path
      end
    end
end
