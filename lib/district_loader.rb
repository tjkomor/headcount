require 'json'

class DistrictLoader
  attr_accessor :data

  def load_json(data_dir)
    filepath = File.join(data_dir, 'districts.json')
    file = File.read(filepath)
    @data = JSON.parse(file, :symbolize_names => true)
  end
end
