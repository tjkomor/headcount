require_relative 'district_loader'
require_relative 'district'

class DistrictRepository
  attr_accessor :loader, :data, :enrollment
  def initialize(data)
    @data = data
    data.map do |name, district_data|
      [name => District.new(name, district_data)]
    end
  end

  def self.from_json(data_dir)
    data = DistrictLoader.new.load_json(data_dir)
    DistrictRepository.new(data)
  end

  def find_by_name(name)
    @data.fetch(name.downcase.to_sym)
  end
end
