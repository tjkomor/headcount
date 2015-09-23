require_relative 'enrollment'
require_relative 'statewide_testing'
require_relative 'economic_profile'

class District
  attr_accessor :enrollment, :statewide_testing, :economic_profile

  def initialize(name, data)
    @name = name
    @enrollment = Enrollment.new(data)
    @statewide_testing = StatewideTesting.new(data)
    @economic_profile = EconomicProfile.new(data)
  end

  def name
    if @name.respond_to?(:to_s)
      @name = @name.to_s.upcase
    else
      @name = @name
    end
  end
end
