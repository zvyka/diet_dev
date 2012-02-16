module ApplicationHelper
  
  # Logo
  def logo
    logo = image_tag("new_logo_5.png", :alt => "Team DIET", :class => "logo_style")
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
  
  #sorting columns
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
