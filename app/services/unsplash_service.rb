class UnsplashService

  def random_photo
    response = self.class.get('photos/random')
    JSON.parse(response.body)
  end

  def logo
    response = connection.get("/photos/MCO0-A98XQw")
    JSON.parse(response.body, symbolize_names: true)[:urls][:thumb]
  end

  def get_photos
    response = connection.get("/photos")
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new(url:'https://api.unsplash.com', params: {"client_id" => "EF3XCM-B_GVNzvSJL-tVaaXIFOgGxl99QvZTTIO0Ve8"})

  end
end