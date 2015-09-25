require './lib/enrollment.rb'
require './lib/district_repository'
require './lib/district'
require './lib/custom_errors'
include Errors

class EnrollmentTest < Minitest::Test

  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_it_can_find_participation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 2752, district.enrollment.participation_in_year(2010)
  end

  def test_it_knows_the_known_races
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal [:white, :asian, :black, :hispanic, :two_or_more, :pacific_islander, :native_american,
      :all_students, :female_students, :male_students], district.enrollment.known_races
  end

  def test_it_can_find_graduation_rate_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.814, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_it_can_find_dropout_rate_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.013, district.enrollment.dropout_rate_in_year(2011)
  end

  def test_it_can_find_dropout_rate_by_gender_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal '', district.enrollment.dropout_rate_by_gender_in_year(2011)
  end

  def test_it_can_find_online_participation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 77, district.enrollment.online_participation_in_year(2011)
  end

  def test_it_can_find_hash_of_online_particiaption
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2011=>77, 2012=>42, 2013=>37}
    assert_equal expected, district.enrollment.online_participation_by_year
  end


  def test_it_can_find_hash_by_race_or_ethnicity
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2007=>0.01, 2008=>0.014, 2009=>0.013, 2010=>0.01, 2011=>0.005, 2012=>0.006, 2013=>0.007, 2014=>0.007}
    assert_equal expected, district.enrollment.participation_by_race_or_ethnicity("asian")
  end

  def test_it_can_return_races_with_rates
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {:native_american=>0.01, :asian=>0.01, :black=>0.01, :hispanic=>0.08, :pacific_islander=>0, :two_or_more=>0.04, :white=>0.86}
    assert_equal expected, district.enrollment.participation_by_race_or_ethnicity_in_year(2010)
  end

  def test_it_can_find_races_and_dropout_rates
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {:native_american=>0.01, :asian=>0.01, :black=>0.01, :hispanic=>0.08, :pacific_islander=>0, :two_or_more=>0.04, :white=>0.86}
    assert_equal expected, district.enrollment.participation_by_race_or_ethnicity_in_year(2010)
  end

  def test_it_can_find_special_education_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2009=>0.094, 2011=>0.077, 2012=>0.08, 2013=>0.081, 2010=>0.082, 2014=>0.085}
    assert_equal expected, district.enrollment.special_education_by_year
  end

  def test_it_can_find_special_education_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.094, district.enrollment.special_education_in_year(2009)
  end

  def test_it_can_find_remediation_by_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2011=>0.348, 2010=>0.415, 2009=>0.357}
    assert_equal expected, district.enrollment.remediation_by_year
  end

  def test_it_can_find_remediation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.348, district.enrollment.remediation_in_year(2011)
  end

  def test_it_can_find_kindergarten_participation_by_year
    dr       = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2007 => 0, 2006 => 0, 2005 => 0.005, 2004 => 0, 2008 => 0, 2009 => 1, 2010 => 1, 2011 => 1, 2012 => 1, 2013 => 1, 2014 => 1}
    assert_equal expected, district.enrollment.kindergarten_participation_by_year
  end

  def test_it_can_find_kindergarten_participation_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 1, district.enrollment.kindergarten_participation_in_year(2011)
  end

  def test_it_can_find_dropout_rate_by_gender_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {"female"=>0.016, "male"=>0.011}
    assert_equal expected, district.enrollment.dropout_rate_by_gender_in_year(2011)
  end

  def test_it_can_find_dropout_rate_for_race_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0, district.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2011)
  end

  def test_it_can_find_races_and_dropout_rates_and_return_hash
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {:asian=>0, :black=>0, :pacific_islander=>0, :hispanic=>0.008, :native_american=>0, :two_or_more=>0.03, :white=>0.013}
    assert_equal expected, district.enrollment.dropout_rate_by_race_in_year(2011)
  end

  def test_it_can_return_years_associated_with_race
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    expected = {2011=>0.013, 2012=>0.007}
    assert_equal expected, district.enrollment.dropout_rate_for_race_or_ethnicity(:white)
  end

end
