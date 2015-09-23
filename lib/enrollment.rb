class Enrollment
  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:enrollment)
  end

  def participation_in_year(year)
    @data[:participation_by_year][year.to_s.to_sym]
  end

  def graduation_rate_in_year(year)
    # require 'pry';binding.pry
    @data[:graduation_rate_by_year][year.to_s.to_sym]
  end

  def dropout_rate_in_year(year)
    dropouts = @data[:dropout_rates]
  end

  def online_participation_by_year
    @data[:online_participation_by_year]
  end

  def online_participation_in_year(year)
    participation = @data[:online_participation_by_year]
    participation.fetch(year.to_s.to_sym)
  end

  # def dropout_rate_by_gender_in_year(year)
  #     dropouts = @data[:dropout_rates]
  #     dropouts.fetch(year)
  # end
end
