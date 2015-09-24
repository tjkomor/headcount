require_relative 'custom_errors'
include Errors

class StatewideTesting
  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:statewide_testing)
  end

  def known_races
    [:white, :asian, :black, :hispanic, :two_or_more, :pacific_islander, :native_american,
      :all_students, :female_students, :male_students]
  end

  def known_subjects
    [:math, :writing, :reading]
  end

  def known_years
    [2011,2012,2013,2014]
  end

  def proficient_by_grade(grade)
    data_by_year = @data.fetch(:by_subject_year_and_grade)
    if (grade == 3) || (grade == 8)
      data_by_year = data_by_year.select { |k| k[:grade] == grade }
                                 .group_by { |data| data[:year] }
      @output = {}
      format_proficiency_hash(data_by_year)
      @output
    else
      raise UnknownDataError
    end
  end

  def format_proficiency_hash(data_by_year)
    data_by_year.each do |k, v|
      scores = []
      v.each { |hash| scores << {hash[:subject].downcase.to_sym => hash[:proficiency].to_f}}
      @output[k.to_i] = scores[0].merge(scores[1]).merge(scores[2])
    end
  end

  def error
    raise UnknownDataError
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if known_subjects.include?(subject)
      data_by_grade = proficient_by_grade(grade)
      value_year = data_by_grade.select {|hash| hash == year}
      if value_year.empty?
        raise UnknownDataError
      end
      value_year.fetch(year).fetch(subject)
    else
      raise UnknownDataError
    end
  end

  def unknown
    raise UnknownDataError
  end

  def subject?(subject)
    if subject == :reading
      true
    elsif subject == :math
      true
    elsif subject == :writing
      true
    else
      raise UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    if known_subjects.include?(subject)
      data_by_race = @data.fetch(:by_subject_year_and_race)
      .select { |k| k[:race] == "all" }
      .select { |k| k[:subject] == subject.to_s}
      .select { |k| k[:year] == year}
      if data_by_race.empty?
        raise UnknownDataError
      else
        data_by_race.first.fetch(:proficiency)
      end
    else
      raise UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    if !known_races.include?(race)
      raise UnknownDataError
    else
    race = race.to_s
      results = Hash.new
      data_by_race = @data.fetch(:by_subject_year_and_race)
                          .select { |k| k[:race] == race }
                        end
    if !data_by_race.empty?
      find_subject_by_race(data_by_race)
      format_race_and_ethnicity_hash(data_by_race, results)
    else
      raise UnknownDataError
    end
  end

  def find_subject_by_race(data_by_race)
    @output = {}
    @output[:math]    = data_by_race.select { |k| k[:subject] == "math"}
    @output[:reading] = data_by_race.select { |k| k[:subject] == "reading"}
    @output[:writing] = data_by_race.select { |k| k[:subject] == "writing"}
  end

  def format_race_and_ethnicity_hash(data_by_race, results)
    @output.each do |key, rel|
      rel.each do |k|
        year = k.fetch(:year)
        subject = key
        results[year] ||= Hash.new
        results[year][subject] = k[:proficiency].to_f
      end
    end
    results
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if valid?(subject, race, year)
      data_by_race = proficient_by_race_or_ethnicity(race)
        data_by_race[year][subject]
      end
  end

  def valid?(subject, race, year)
    if known_subjects.include?(subject) && known_races.include?(race) && known_years.include?(year)
      true
    else
      raise UnknownDataError
    end
  end
end
