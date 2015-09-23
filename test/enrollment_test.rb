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
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal .013, district.enrollment.dropout_rate_in_year(2010)
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
    skip
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.online_participation_by_year
  end

  def test_it_can_find_participation_by_year
    skip
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.online_participation_in_year
  end

  def test_it_can_find_hash_by_race_or_ethnicity
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.participation_by_race_or_ethnicity(:asian)
  end

  def test_it_can_find_by_race_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.01, district.enrollment.participation_by_race_or_ethnicity_in_year(2010)
  end

  def test_it_can_find_special_education_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.special_education_by_year
  end

  def test_it_can_find_special_education_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.094, district.enrollment.special_education_in_year(2009)
  end

  def test_it_can_find_remediation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.remediation_by_year
  end

  def test_it_can_find_remediation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.348, district.enrollment.remediation_in_year(2011)
  end

  def test_it_can_find_kindergarten_participation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.kindergarten_participation_by_year
  end

  def test_it_can_find_kindergarten_participation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 1, district.enrollment.kindergarten_participation_in_year(2011)
  end

end
