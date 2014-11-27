Geocoder.configure(
  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,
  #:lookup => :yahoo,

  lookup: :bing,
  api_key: 'AoNvFv-tODwqbAfMyZdLBLIaxPzyj6rn6D6Ed6a2MaKY04auUMlO2sj7iX6y1v9E', # ENV['BING_GEOCODE_ID'] instead?
  # Microsoft account: francesc@gestinet.com
  cache: Rails.cache,

)
