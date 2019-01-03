class Spree::SearchOrderController < Spree::StoreController
  def index
    #TestMailer.test_email("myknotto@gmail.com").deliver_now
    @order = Spree::Order.find_by(
        #number: params[:orderkeyword],email: params[:emailkeyword]
        'upper(number) = ? and lower(email) = ?', params[:orderkeyword].upcase,params[:emailkeyword].downcase
    ) if params[:orderkeyword].present? and params[:emailkeyword].present?
  end
end