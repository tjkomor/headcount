require_relative 'district_loader'
require_relative 'district'

class DistrictRepository
  attr_accessor :loader, :data, :enrollment, :districts
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

  # def name
  #   if @districts.key.class == String
  #     @name = @districts.key
  #   else
  #     @name = @districts.key.to_s
  #   end
  # end

  def find_all_matching(name)
    a = []
    name = name.upcase.to_sym
    @districts.select do |key, value|
       if key.to_s.include?(name.to_s)
         a << key.to_s
       end
    end
    a
  end
end
