module Errors

class UnknownRaceError < StandardError
end
class KeyError < StandardError
end

end

include Errors
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

  def known_races
    [:white, :asian, :black, :hispanic, :two_or_more, :pacific_islander, :native_american,
      :all_students, :female_students, :male_students]
  end

  def graduation_rate_in_year(year)
    @data[:graduation_rate_by_year][year.to_s.to_sym]
  end

  def graduation_rate_by_year
    @data[:graduation_rate_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def kindergarten_participation_by_year
    hash = @data[:kindergarten_participation_by_year]
    hash.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_by_year.fetch(year, nil)
  end

  def dropout_rate_in_year(year)
    dropout = @data[:dropout_rates]
    dropout.map do |blk|
      if blk[:year] == year && blk[:category] == 'all'
          return blk[:rate]
      end
    end
    nil
  end

  def dropout_rate_by_gender_in_year(year)
    if year > 2012 || year < 2011
      return nil
    else
      final_hash = {}
      rates = @data[:dropout_rates]
      correct_year = rates.select {|hash| hash[:year] == year}
      males = correct_year.select {|hash| hash[:category] == "male"}
      females = correct_year.select {|hash| hash[:category] == "female"}
      female_hash = females.first
      male_hash = males.first
      final_hash[female_hash[:category].to_sym] = female_hash[:rate]
      final_hash[male_hash[:category].to_sym] = male_hash[:rate]
      final_hash
    end
  end

  def online_participation_by_year
    online = @data[:online_participation_by_year]
    online.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def online_participation_in_year(year)
    participation = @data[:online_participation_by_year]
    participation.fetch(year.to_s.to_sym, nil)
  end

  def participation_by_race_or_ethnicity(race)
    if !known_races.include?(race)
      raise UnknownRaceError
    else
      all_years = []
      year = []
      rate = []
      participation = @data[:participation_by_race_and_year]
      participation.each do |blk|
        if blk[:race] == race.to_s
          all_years << blk
        end
      end
    end
    all_years.each do |blk|
      year << blk[:year]
      rate << blk[:rate]
    end
    year.zip(rate).to_h
  end

  def participation_by_race_or_ethnicity_in_year(year)
    races = []
    rates = []
    data = @data[:participation_by_race_and_year]
      data.each do |hash|
        if hash[:year] == year
          races << hash[:race].to_sym
          rates << hash[:rate]
        end
      end
      result = races.zip(rates).to_h
      result if result.any? 
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    if !known_races.include?(race)
      raise UnknownRaceError
    elsif year > 2012 || year < 2011
      nil
    else
      string = race.to_s
      data = @data[:dropout_rates]
      years = data.select {|hash| hash[:year] == year}
      results = years.select {|hash| hash[:category] == string}
      results.first[:rate]
    end
  end

  def dropout_rate_by_race_in_year(year)
    if year > 2012 || year < 2011
      return nil
    else
      results = {}
      data = @data[:dropout_rates]
      years = data.select {|hash| hash[:year] == year}
      array = years.select {|hash| hash[:year] == year}
      asian = array.select {|hash| hash[:category] == 'asian'}
      black = array.select {|hash| hash[:category] == 'black'}
      pacific_islander = array.select {|hash| hash[:category] == 'pacific_islander'}
      hispanic = array.select {|hash| hash[:category] == 'hispanic'}
      native_american = array.select {|hash| hash[:category] == 'native_american'}
      two_or_more = array.select {|hash| hash[:category] == 'two_or_more'}
      white = array.select {|hash| hash[:category] == 'white'}
      results[asian.first[:category].to_sym] = asian.first[:rate]
      results[black.first[:category].to_sym] = black.first[:rate]
      results[pacific_islander.first[:category].to_sym] = pacific_islander.first[:rate]
      results[hispanic.first[:category].to_sym] = hispanic.first[:rate]
      results[native_american.first[:category].to_sym] = native_american.first[:rate]
      results[two_or_more.first[:category].to_sym] = two_or_more.first[:rate]
      results[white.first[:category].to_sym] = white.first[:rate]
      results
    end
  end

  def dropout_rate_for_race_or_ethnicity(race)
      if !known_races.include?(race)
        raise UnknownRaceError
      else
        year = []
        rates = []
        @data[:dropout_rates].each do |hash|
          if hash[:category] == race.to_s
            year << hash[:year]
            rates << hash[:rate]
          end
        end
    end
    result = year.zip(rates).to_h
  end

  def special_education_by_year
    education = @data[:special_education_by_year]
    education.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def special_education_in_year(year)
    special_education_by_year.fetch(year, nil)
  end

  def remediation_by_year
    remediation = @data[:remediation_by_year]
    remediation.map { |key, value| [key.to_s.to_i, value] }.to_h
  end

  def remediation_in_year(year)
    remediation_by_year.fetch(year, nil)
  end
end
