module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  #Returns profile picture of a user.
  def profile_picture(user, size: 100)
    if user.image?
      image_tag("http://graph.facebook.com/v2.10/#{@user.uid}/picture?type=large", class:"full-image")
    else
      gravatar_for(user, size: "250")
    end
  end
end