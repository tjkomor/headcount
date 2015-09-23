class StatewideTesting
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
      "UNKNOWNGRADEERROR"
    end
  end

  def format_proficiency_hash(data_by_year)
    data_by_year.each do |k, v|
      scores = []
      v.each { |hash| scores << {hash[:subject].downcase.to_sym => hash[:proficiency].to_f}}
      @output[k.to_i] = scores[0].merge(scores[1]).merge(scores[2])
    end
  end
end