#class Spreesubdistrict < ApplicationRecord
#end
module Spree
  class Subdistrict < Spree::Base
    belongs_to :district, class_name: 'Spree::District'
    has_many :addresses, dependent: :restrict_with_error

    validates :district, :name, presence: true
    #validates :name, :code, uniqueness: { case_sensitive: false, scope: :district_id }, allow_blank: true

    #self.whitelisted_ransackable_attributes = %w(code)

    #def self.find_all_by_name_or_code(name_or_code)
    #  where('name = ? OR code = ?', name_or_code, name_or_code)
    #end

    # table of { country.id => [ state.id , state.name ] }, arrays sorted by name
    # blank is added elsewhere, if needed
    def self.subdistricts_group_by_district_id
      subdistrict_info = Hash.new { |h, k| h[k] = [] }
      order(:name).each do |subdistrict|
        subdistrict_info[subdistrict.district_id.to_s].push [subdistrict.id, subdistrict.name]
      end
      subdistrict_info
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