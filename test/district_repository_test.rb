require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
 def data_dir
   File.expand_path '../data', __dir__
 end

 def test_it_can_load_a_district_from_csv_data
   dr = DistrictRepository.from_json(data_dir)
   district = dr.find_by_name("ACADEMY 20")

   assert_equal 22620, district.enrollment.participation_in_year(2009)
   assert_equal 0.895, district.enrollment.graduation_in_year(2010)
  #  assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
 end

 def test_it_can_find_all_matching
   dr = DistrictRepository.from_json(data_dir)
   district = dr.find_all_matching("oRa")
   assert_equal ["COLORADO", "COLORADO SPRINGS 11"], district
 end
end
