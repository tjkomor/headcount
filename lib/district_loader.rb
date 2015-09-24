require 'json'

class DistrictLoader
  attr_accessor :data

  def load_json(data_dir)
    filepath = File.join(data_dir, 'districts.json')
    file = File.read(filepath)
    @data = JSON.parse(file, :symbolize_names => true)
    parse_enrollment_data
    parse_economic_profile_data
  end

  def parse_enrollment_data
    parse_graduation_rate_by_year
    parse_kindergarten_graduation_by_year
    parse_participation_by_year
    parse_online_participation_by_year
    parse_special_education_by_year
    parse_remediation_by_year
  end

  def parse_economic_profile_data
    parse_title_1_students_by_year
    parse_free_or_reduced_lunch_by_year
  end

  def parse_graduation_rate_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:graduation_rate_by_year] = enrollment[:graduation_rate_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_kindergarten_graduation_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:kindergarten_participation_by_year] = enrollment[:kindergarten_participation_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_participation_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:participation_by_year] = enrollment[:participation_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_online_participation_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:online_participation_by_year] = enrollment[:online_participation_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_special_education_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:special_education_by_year] = enrollment[:special_education_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_remediation_by_year
    @data = @data.map { |district_name, district_data|
      enrollment = district_data[:enrollment]
      enrollment[:remediation_by_year] = enrollment[:remediation_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_title_1_students_by_year
    @data = @data.map { |district_name, district_data|
      economic_profile = district_data[:economic_profile]
      economic_profile[:title_1_students_by_year] = economic_profile[:title_1_students_by_year].map { |key, value| [key.to_s.to_i, value] }.to_h
      [district_name, district_data]
    }.to_h
  end

  def parse_free_or_reduced_lunch_by_year
    @data = @data.map { |district_name, district_data|
      economic_profile = district_data[:economic_profile]
      economic_profile[:free_or_reduced_lunch_by_year] = economic_profile[:free_or_reduced_lunch_by_year].map {|key, value| [key.to_s.to_i, value]  }.to_h
      [district_name, district_data]
    }.to_h
  end
end
