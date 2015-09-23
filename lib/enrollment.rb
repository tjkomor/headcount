class Enrollment
  attr_accessor :data

  def initialize(data)
    @data = data.fetch(:enrollment)
  end

  def participation_in_year(year)
    @data[:participation_by_year][year.to_s.to_sym]
  end

  def participation_by_year
    @data[:participation_by_year]
  end

  def graduation_rate_in_year(year)
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
    @data[:special_education_by_year]
  end

  def special_education_in_year(year)
    special_education_by_year.fetch(year.to_s.to_sym)
  end


  # def dropout_rate_by_gender_in_year(year)
  #     dropouts = @data[:dropout_rates]
  #     dropouts.fetch(year)
  # end
end
