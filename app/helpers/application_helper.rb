Yaup.helpers do

  def render_rating(rating)
    # "+" * (rating*2).to_i
    image_tag("stars/#{rating}.png", :class => "stars #{rating.to_s.gsub(".", "_")}")
  end
  
end