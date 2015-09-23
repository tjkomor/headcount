class Enrollment
  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:enrollment)
  end

  def participation_in_year(year)
    @data[:participation_by_year][year.to_s.to_sym]
  end

  def graduation_in_year(year)
    @data[:graduation_rate_by_year][year.to_s.to_sym]
  end
end
