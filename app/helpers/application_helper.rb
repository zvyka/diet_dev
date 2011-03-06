module ApplicationHelper
  
  # Logo
  def logo
    logo = image_tag("DIET-logo_small.png", :alt => "Team DIET", :class => "round", :size => "150x150")
  end
  
  # Return a title on a per-page basis.
  def title
    base_title = "Team DIET Tracker"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
