class Photo
  attr_reader :url, :likes
  def initialize(photo_info)
    @url = photo_info[:urls]
    @likes = photo_info[:likes]
  end
end