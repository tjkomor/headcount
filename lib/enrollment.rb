class Enrollment
  attr_accessor :data
  def initialize(data)
    @data = data
  end

  def in_year(year)
    @data[:enrollment][:participation_by_year][year.to_s.to_sym]
  end

  def graduation_in_year(year)
    @data[:enrollment][:graduation_rate_by_year][year.to_s.to_sym]
  end
end
