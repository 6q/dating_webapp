Geocoder.configure(
  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,
  #:lookup => :yahoo,

  lookup: :bing,
  api_key: 'Aks_Erhf-lo2nJHiaa8x1jTG_MjY6IJjzs8fAnJ_O7jd-0kPqOkDhExRt1c9ue0w', # ENV['BING_GEOCODE_ID'] instead?
  cache: Rails.cache,

)
