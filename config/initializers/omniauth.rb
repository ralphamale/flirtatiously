Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :scope => 'email,user_birthday,read_stream,user_photos', :display => 'popup', :image_size => 'large'
end




