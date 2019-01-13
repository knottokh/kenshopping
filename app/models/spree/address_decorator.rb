Spree::Address.class_eval do
   belongs_to :district, class_name: 'Spree::District', optional: true
   belongs_to :subdistrict, class_name: 'Spree::Subdistrict', optional: true
end