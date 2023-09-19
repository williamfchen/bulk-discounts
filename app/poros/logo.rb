class logo
  attr_reader :image
  def initialize(photo_data)
    @image = photo_data[:urls][:thumb]
  end
end