require_relative 'enrollment'
require_relative 'statewide_testing'
require_relative 'economic_profile'

class District
  attr_accessor :enrollment, :statewide_testing, :economic_profile, :name

  def initialize(name, data)
    @name = name
    @enrollment = Enrollment.new(data)
    @statewide_tesing = StatewideTesting.new(data)
    @statewide_testing = StatewideTesting.new(data)
    @economic_profile = EconomicProfile.new(data)
  end

  def name
    if @name.class == String
      @name = @name
    else
      @name = @name.to_s.upcase
    end
  end
end
