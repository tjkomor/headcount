class StatewideTesting

def initialize(data)
  @data = data
end

  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:statewide_testing)
  end

  def proficient_by_grade(grade)
    data_by_year = @data.fetch(:by_subject_year_and_grade)
    if grade == 3 || 8
      data_by_year = data_by_year.select { |k| k[:grade] == grade }
                                 .group_by { |data| data[:year] }
      @output = {}
      format_proficiency_hash(data_by_year)
      @output
    else
      raise UNKNOWNGRADEERROR
    end
  end

  def format_proficiency_hash(data_by_year)
    data_by_year.each do |k, v|
      scores = []
      v.each { |hash| scores << {hash[:subject].downcase.to_sym => hash[:proficiency].to_f}}
      @output[k.to_i] = scores[0].merge(scores[1]).merge(scores[2])
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    data_by_grade = proficient_by_grade(grade)
    value_year = data_by_grade.fetch(year)
    value_year.fetch(subject)
  end

  def proficient_for_subject_in_year(subject, year)
    if subject == :reading || :math || :reading
      three = proficient_by_grade(3)
      eight = proficient_by_grade(8)
      third = three.fetch(year)
      eighth = eight.fetch(year)
      x = eighth.fetch(subject)
      y = third.fetch(subject)
      (x + y) / 2
    else
      raise UNKNOWNDATAERROR
    end
  end

  def proficient_by_race_or_ethnicity(race)
    race = race.to_s
    results = Hash.new
    data_by_race = @data.fetch(:by_subject_year_and_race)
                        .select { |k| k[:race] == race }
    find_subject_by_race(data_by_race)
    format_race_and_ethnicity_hash(data_by_race, results)
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
    data_by_race = proficient_by_race_or_ethnicity(race)
    data_by_race[year][subject]
  end


end
