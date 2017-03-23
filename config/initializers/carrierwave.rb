CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],                        # required
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],                        # required
      region:                'eu-central-1'                  # optional, defaults to 'us-east-1'
      # host:                  'http://canvas-storage.s3-website.eu-central-1.amazonaws.com',             # optional, defaults to nil
      # endpoint:              'http://canvas-storage.s3-website.eu-central-1.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'canvas-storage'                          # required
  config.fog_public     = true                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end

# Use local storage if in development or test
if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# Use AWS storage if in production
if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
  end
end