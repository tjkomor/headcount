require_relative 'district_repository'
require_relative 'district'

class HeadcountAnalyst
  attr_accessor :data

  def initialize
    dr = DistrictRepository.new(data)
    @analyst = HeadcountAnalyst.new(dr)
  end

  def top_statewide_testing_year_over_year_growth(hash)
    @analyst.data(hash)
  end

end
