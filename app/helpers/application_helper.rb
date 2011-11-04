module ApplicationHelper
  def get_target(key)
    [:facebook, :github, :flickr, :hulu, :picasa, :twitter].include?(key) ? "_blank" : "iframe_a"
  end
end
