class Business
  
  attr_accessor :json_data
  
  def initialize(json_data)
    self.json_data = json_data
  end

  def name
    json_data['name']
  end
  
  def location
    out = []
    if json_data['location']['cross_streets'].present?
      out << json_data['location']['cross_streets']
    else
      out << json_data['location']['address'] 
      out << json_data['location']['postal_code'] 
    end
    out.join(" ")
  end
  
  def display_address
    json_data['location']['display_address'].first
  end
  
  def review_count
    json_data['review_count'].to_i
  end
  
  def rating
    json_data['rating_img_url_small'].split("/").last.gsub(/stars\_small\_(.*)\.png/, '\\1').gsub("_half", ".5").to_f
  end
  
end