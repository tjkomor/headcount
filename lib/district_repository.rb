require_relative 'district_loader'
require_relative 'district'

class DistrictRepository
  attr_accessor :loader, :data, :enrollment, :districts, :name, :matching_results
  def initialize(data)
    @data = data
    @districts = data.map {|name, district_data| [name.upcase, District.new(name, district_data)] }.to_h
  end

  def self.from_json(data_dir)
    data = DistrictLoader.new.load_json(data_dir)
    DistrictRepository.new(data)
  end

  def find_by_name(name)
    if districts.include?(name.upcase.to_sym)
      @districts.fetch(name.upcase.to_sym)
    else
      nil
    end
  end

  def find_all_matching(name)
    @matching_results = []
    name = name.upcase.to_sym
    @districts.each do |district_name, district_data|
       if district_name.to_s.include?(name.to_s)
         @matching_results << district_data
       end
    end
    @matching_results
  end
end
