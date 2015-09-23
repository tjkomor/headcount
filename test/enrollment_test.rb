require './lib/enrollment.rb'
require './lib/district_repository'
require './lib/district'

class EnrollmentTest < Minitest::Test

  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_it_can_find_participation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 2752, district.enrollment.participation_in_year(2010)
  end

  def test_it_can_find_graduation_rate_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.814, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_it_can_find_dropout_rate_in_year
    skip
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.dropout_rate_in_year(2010)
  end

  def test_it_can_find_dropout_rate_by_gender_in_year
    skip
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.dropout_rate_by_gender_in_year(2010)
  end

  def test_it_can_find_online_participation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 77, district.enrollment.online_participation_in_year(2011)
  end

  def test_it_can_find_hash_of_online_particiaption
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal {:"2011"=>77, :"2012"=>42, :"2013"=>37}, district.enrollment.online_participation_by_year
  end
end
