require './lib/district_repository'
require './lib/district'
require './lib/statewide_testing'

class StatewideTestingTest < Minitest::Test
  def data_dir
    File.expand_path '../data', __dir__
  end

  def setup
@third_grade_results =  {2008=>{:math=>0.798, :reading=>0.838, :writing=>0.556},
                         2009=>{:math=>0.769, :reading=>0.799, :writing=>0.616},
                         2010=>{:math=>0.715, :reading=>0.76, :writing=>0.515},
                         2011=>{:math=>0.708, :reading=>0.739, :writing=>0.503},
                         2012=>{:reading=>0.824, :math=>0.818, :writing=>0.598},
                         2013=>{:math=>0.72, :reading=>0.78, :writing=>0.505},
                         2014=>{:math=>0.70, :reading=>0.763, :writing=>0.514}}

@eighth_grade_results = {2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},
                         2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},
                         2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},
                         2011=>{:reading=>0.832, :math=>0.653, :writing=>0.745},
                         2012=>{:math=>0.681, :writing=>0.738, :reading=>0.833},
                         2013=>{:math=>0.661, :reading=>0.852, :writing=>0.75},
                         2014=>{:math=>0.684, :reading=>0.827, :writing=>0.747}}

@subject_by_race_results = {2011=>{:math=>0.0, :reading=>0.0, :writing=>0.0},
                            2012=>{:math=>0.0, :reading=>0.0, :writing=>0.0},
                            2013=>{:math=>0.0, :reading=>0.0, :writing=>0.0},
                            2014=>{:math=>0.0, :reading=>0.0, :writing=>0.0}}
  end

  def test_it_can_find_proficiency_by_grade_for_a_district
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal @third_grade_results, district.statewide_testing.proficient_by_grade(3)
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('ACADEMY 20')
    assert_equal @eighth_grade_results, district.statewide_testing.proficient_by_grade(8)
  end

  def test_it_can_find_proficiency_by_race_or_ethnicity
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal @subject_by_race_results, district.statewide_testing.proficient_by_race_or_ethnicity(:asian)

  end

  def test_it_can_find_proficient_for_subject_by_grade_in_a_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('WOODLAND PARK RE-2')
    assert_equal 0.708, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2011)
  end

  def test_it_can_find_proficiency_for_subject_in_a_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('ACADEMY 20')
    assert_equal 0.68, district.statewide_testing.proficient_for_subject_in_year(:math, 2011)
  end

  def test_it_can_find_subject_by_race_in_year
    dr = DistrictRepository.from_json(data_dir)
    district = dr.find_by_name('ACADEMY 20')
    assert_equal 0.816, district.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2011)
  end

end
