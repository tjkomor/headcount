require_relative 'custom_errors'
include Errors

class EconomicProfile
  attr_accessor :data, :free_lunch

  def initialize(data)
    @data = data.fetch(:economic_profile)
  end

  def free_or_reduced_lunch_by_year
     data = @data.fetch(:free_or_reduced_lunch_by_year)
     data.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    free_lunch = free_or_reduced_lunch_by_year
    free_lunch = free_lunch.fetch(year, @unknownerror)
  end

  def unknownerror
    raise KeyError
  end

  def school_aged_children_in_poverty_by_year
    poverty = @data.fetch(:school_aged_children_in_poverty_by_year)
    poverty.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def school_aged_children_in_poverty_in_year(year)
    poverty = school_aged_children_in_poverty_by_year
    poverty.fetch(year, @unknownerror)
  end

  def title_1_students_by_year
    title = @data.fetch(:title_1_students_by_year)
    title.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def title_1_students_in_year(year)
    title = title_1_students_by_year
    title.fetch(year, @unknownerror)
  end
end
