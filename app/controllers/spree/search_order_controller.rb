class Spree::SearchOrderController < Spree::StoreController
  def index
    #TestMailer.test_email("myknotto@gmail.com").deliver_now
    @order = Spree::Order.find_by(
        #number: params[:orderkeyword],email: params[:emailkeyword]
        'upper(number) = ? and lower(email) = ?', params[:orderkeyword].upcase,params[:emailkeyword].downcase
    ) if params[:orderkeyword].present? and params[:emailkeyword].present?
    #Spree::OwnerMailer.payment_email(Spree::Order.find(15)).deliver_now
  end
  def show
  end
  def filter_units_by_postcode
     @addr_type = (params[:address_type] == "s" ? "order_ship": "order_bill") if params[:address_type].present?
     @filterd_district = Spree::District.where(postcode: params[:selected_postcode]).first if params[:selected_postcode].present?
  end
end