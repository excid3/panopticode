class MainController < ApplicationController
  def index
    redirect_to "/#{params[:twitter_id].first.gsub "@", ""}" if params[:twitter_id]
  end

  def show
    @twitter = params[:twitter_id]

    begin
      user = Twitter.user @twitter
    rescue
      flash[:alert] = "Invalid twitter user"
      redirect_to root_path and return
    end

    @timezone = user.time_zone
    @avatar = user.profile_image_url
    @url = user.url
    @name = user.name
    @location = user.location

    @sites = {
      :aboutme => "http://about.me/#{@twitter}",
      :github => "https://github.com/#{@twitter}",
      :twitter => "https://twitter.com/#{@twitter}",
      :facebook => "http://facebook.com/#{@twitter}",
      :gravatar => "http://en.gravatar.com/#{@twitter}",
      :blogspot => "http://#{@twitter}.blogspot.com",
      :disqus => "http://disqus.com/#{@twitter}",
      :wordpress => "http://#{@twitter}.wordpress.com",
      :tumblr => "http://#{@twitter}.tumblr.com",
      :deviantart => "http://#{@twitter}.deviantart.com",
      :picasa => "http://picasaweb.google.com/#{@twitter}",
      :flickr => "http://flickr.com/#{@twitter}",
      :lastfm => "http://last.fm/user/#{@twitter}",
      :soundcloud => "http://soundcloud.com/#{@twitter}",
      :hulu => "http://hulu.com/profiles/#{@twitter}",
      :ustream => "http://ustream.tv/user/#{@twitter}",
      :vimeo => "http://vimeo.com/#{@twitter}",
      :digg => "http://digg.com/users/#{@twitter}",
      :foursquare => "http://foursquare.com/#{@twitter}",
      :stumbleupon => "http://stumbleupon.com/stumbler/#{@twitter}",
      :twitpic => "http://twitpic.com/photos/#{@twitter}",
      :yfrog => "http://yfrog.com/user/#{@twitter}/profile",
      :linkedin => "http://www.linkedin.com/in/#{@twitter}",
    }

    @sites.delete_if { |k, v| not valid_url(v) }

  end

  private

  def valid_url(url)
    open(url) rescue false
  end
end
