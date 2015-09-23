require_relative 'district_repository'
require_relative 'district'
require_relative 'district_loader'

class HeadcountAnalyst
  attr_accessor :data

  def self.get_data
    dr = DistrictRepository.from_json(data_dir)
    HeadcountAnalyst.new(dr)
  end

  def top_statewide_testing_year_over_year_growth(hash)
    @data
  end

end
