# class UnsplashService

#   def logo
#     response = connection.get("/photos/MCO0-A98XQw")
#     parsed = JSON.parse(response.body, symbolize_names: true)#[:urls][:thumb]
#     logo_photo = Photo.new(parsed)
#   end

#   def random_photo
#     response = connection.get("/photos/random")
#     parsed = JSON.parse(response.body, symbolize_names: true)
#     photo = Photo.new(parsed)
#   end

#   def search_photo(query)
#     response = connection.get("/search/photos?page=1&query=#{query}")
#     parsed = JSON.parse(response.body, symbolize_names: true)[:results].first
#     photo = Photo.new(parsed)
#   end

#   def connection
#     Faraday.new(url:'https://api.unsplash.com', params: {"client_id" => "EF3XCM-B_GVNzvSJL-tVaaXIFOgGxl99QvZTTIO0Ve8"})

#   end
# end