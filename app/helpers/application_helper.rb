module ApplicationHelper
  def full_title(name)
    if name.empty?
      "Ruby on Rails Tutorial Sample App"
    else
      name + " | "+ "Ruby on Rails Tutorial Sample App"
    end
  end
end
