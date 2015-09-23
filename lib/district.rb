require_relative 'enrollment'
require_relative 'statewide_testing'

class District
  attr_accessor :enrollment, :statewide_testing, :economic_profile

  def initialize(name, data)
    @name = name
    @enrollment = Enrollment.new(data)
    @statewide_testing = StatewideTesting.new(data)
    @economic_profile = EconomicProfile.new(data)
  end
end
