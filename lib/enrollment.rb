class Enrollment
  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:enrollment)
  end

  def participation_in_year(year)
    @data[:participation_by_year][year.to_s.to_sym]
  end

  def participation_by_year
    participation = @data[:participation_by_year]
    participation.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def graduation_rate_in_year(year)
    @data[:graduation_rate_by_year][year.to_s.to_sym]
  end

  def kindergarten_participation_by_year
    hash = @data[:kindergarten_participation_by_year]
    hash.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_by_year.fetch(year.to_s.to_sym)
  end

  def dropout_rate_in_year(year)
    dropout = @data[:dropout_rates]
    dropout.each do |blk|
      if (blk[:year] == year) && (blk[:category] == 'all')
          return blk[:rate]
        else
          nil
      end
    end
  end

  def online_participation_by_year
    online = @data[:online_participation_by_year]
    online.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def online_participation_in_year(year)
    participation = @data[:online_participation_by_year]
    participation.fetch(year.to_s.to_sym)
  end

  def participation_by_race_or_ethnicity(race)
    all_years = []
    year = []
    rate = []
    participation = @data[:participation_by_race_and_year]
    participation.each do |blk|
      if blk[:race] == race.to_s
        all_years << blk
      end
    end
    all_years.each do |blk|
       year << blk[:year]
       rate << blk[:rate]
    end
    year.zip(rate).to_h
  end

  def participation_by_race_or_ethnicity_in_year(year)
    participation_by_race_or_ethnicity.fetch(year)
  end

  def special_education_by_year
    education = @data[:special_education_by_year]
    education.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def special_education_in_year(year)
    special_education_by_year.fetch(year.to_s.to_sym)
  end

  def remediation_by_year
    remediation = @data[:remediation_by_year]
    remediation.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def remediation_in_year(year)
    remediation_by_year.fetch(year.to_s.to_sym)
  end

end
