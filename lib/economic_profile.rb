class EconomicProfile
  attr_accessor :data, :free_lunch

  def initialize(data)
    @data = data.fetch(:economic_profile)
  end

  def free_or_reduced_lunch_by_year
     @data.fetch(:free_or_reduced_lunch_by_year)
  end

  def free_or_reduced_lunch_in_year(year)
    free_lunch = free_or_reduced_lunch_by_year
    free_lunch.fetch(year.to_s.to_sym)
  end
end