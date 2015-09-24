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
    free_lunch = free_lunch.fetch(year.to_s.to_sym)
  end

  def school_aged_children_in_poverty
    @data.fetch(:school_aged_children_in_poverty_by_year)
  end

  def school_aged_children_in_poverty_in_year(year)
    poverty = school_aged_children_in_poverty
    poverty.fetch(year.to_s.to_sym)
  end

  def title_1_students_by_year
    @data.fetch(:title_1_students_by_year)
  end

  def title_1_students_in_year(year)
    title = title_1_students_by_year
    title.fetch(year.to_s.to_sym)
  end
end
