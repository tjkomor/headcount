require './lib/district'
require './lib/district_repository'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test

  def test_it_can_find_a_single_subject_leader
    ha = HeadcountAnalyst.get_data
    assert_equal '', ha.top_statewide_testing_year_over_year_growth(:top => 3, :subject => :math)
  end

end
