require_relative 'district_loader'
require_relative 'district'

class DistrictRepository
  attr_accessor :loader, :data, :enrollment, :districts
  def initialize(data)
    @data = data
    @districts = data.map {|name, district_data| [name, District.new(name, district_data)] }.to_h
  end

  def self.from_json(data_dir)
    data = DistrictLoader.new.load_json(data_dir)
    DistrictRepository.new(data)
  end

  def find_by_name(name)
    @districts.fetch(name.downcase.to_sym)
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)

  end
end
