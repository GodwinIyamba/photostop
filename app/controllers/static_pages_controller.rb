class StaticPagesController < ApplicationController
    require 'flickr'

    def index
        begin
            flickr = Flickr.new(Figaro.env.flickr_api_key, Figaro.env.flickr_shared_secret)
            @user = params[:flickr_id]
            @photos = flickr.photos.getRecent
        rescue Net::OpenTimeout
            redirect_to root_path, notice: "The photos are taking too long to load. Try again."
        end
    end
end
