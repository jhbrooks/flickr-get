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
        msg = "Photostream found!"
        msg_type = "success"
      else
        msg = "Photostream found, but no public photos are available."
        msg_type = "info"
      end
    rescue FlickRaw::FailedResponse
      msg = "User not found."
      msg_type = "danger"
    end
    render partial: "photos", locals: { photos: photos,
                                        msg: msg, msg_type: msg_type }
  end
end
