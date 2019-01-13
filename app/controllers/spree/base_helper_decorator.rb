Spree::BaseHelper.class_eval do
    def available_countries
      checkout_zone = Spree::Zone.find_by(name: Spree::Config[:checkout_zone])

      countries = if checkout_zone && checkout_zone.kind == 'country'
                    checkout_zone.country_list
                  else
                    Spree::Country.where(:isactive => true)
                  end

      countries.collect do |country|
        country.name = Spree.t(country.iso, scope: 'country_names', default: country.name)
        country
      end.sort_by { |c| c.name.parameterize }
    end
end
Spree::PermittedAttributes.class_eval do
  class_variable_set(:@@address_attributes , class_variable_get(:@@address_attributes ).push(:taxid))
  class_variable_set(:@@product_attributes , class_variable_get(:@@product_attributes ).push(:recommend))
end