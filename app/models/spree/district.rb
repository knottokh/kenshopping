#class SpreeDistrict < ApplicationRecord
#end
module Spree
  class District < Spree::Base
    belongs_to :state, class_name: 'Spree::State'
    has_many :addresses, dependent: :restrict_with_error
    has_many :subdistricts, dependent: :destroy

    validates :state, :name, presence: true
    validates :name, :code, uniqueness: { case_sensitive: false, scope: :state_id }, allow_blank: true
    validates :postcode, presence: true
    
    self.whitelisted_ransackable_attributes = %w(code)

    def self.find_all_by_name_or_code(name_or_code)
      where('name = ? OR code = ?', name_or_code, name_or_code)
    end

    # table of { country.id => [ state.id , state.name ] }, arrays sorted by name
    # blank is added elsewhere, if needed
    def self.districts_group_by_state_id
      district_info = Hash.new { |h, k| h[k] = [] }
      order(:name).each do |district|
        district_info[district.state_id.to_s].push [district.id, district.name]
      end
      district_info
    end
    
    def self.default
      district_id = Spree::Config[:default_district_id]
      default = find_by(id: district_id) if district_id.present?
      default || find(1) || first
    end

    def default?
      id == Spree::Config[:default_district_id]
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
