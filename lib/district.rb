require_relative 'enrollment'
class District
  attr_accessor :enrollment
  def initialize(name, data)
    @name = name
    @enrollment = Enrollment.new(data)
  end

end
