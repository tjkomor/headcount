require './lib/district_repository'
require './lib/district'
require './lib/economic_profile'

class EconomicProfileTest < Minitest::Test
  attr_accessor :free_or_reduced_lunch_data

  def data_dir
    File.expand_path '../data', __dir__
  end

  def setup
    @free_or_reduced_lunch_data = {
     :"2014"=>0.067, :"2012"=>0.333,
     :"2011"=>0.233, :"2010"=>0.059,
     :"2009"=>0.259, :"2013"=>0.269,
     :"2008"=>0.227, :"2007"=>0.05,
     :"2006"=>0.046, :"2005"=>0.06,
     :"2004"=>0.101, :"2003"=>0.15,
     :"2002"=>0.038, :"2001"=>0.061,
     :"2000"=>0.03
    }
  end

  def test_it_can_find_free_or_reduced_lunch_participation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal @free_or_reduced_lunch_data, district.economic_profile.free_or_reduced_lunch_by_year
  end

  def test_it_can_find_free_or_reduced_lunch_in_a_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.259, district.economic_profile.free_or_reduced_lunch_in_year(2009)
  end

end