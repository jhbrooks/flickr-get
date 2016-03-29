module StaticPagesHelper
  def user_photos(user_id)
    FlickRaw.api_key = ENV["FLICKR_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SECRET"]
    flickr.photos.search(user_id: user_id)
  end

  def render_photos(user_id)
    begin
      photos = user_photos(user_id)
      if photos.any?
        flash.now[:success] = "Photostream found!"
        render partial: "photos", locals: { photos: photos }
      else
        flash.now[:info] = "Photostream found, but no public photos are "\
                           "available."
        return
      end
    rescue FlickRaw::FailedResponse
      flash.now[:danger] = "User not found."
      return
    end
  end
end
