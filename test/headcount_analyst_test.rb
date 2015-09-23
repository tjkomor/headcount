require './lib/district'
require './lib/district_repository'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test

  def test_it_can_find_a_single_subject_leader
    ha = HeadcountAnalyst.get_data
    assert_equal '', ha.data
  end

end
