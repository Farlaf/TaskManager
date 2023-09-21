module ImageProcessingService
  class << self
    def crop!(path_to_image, crop_width, crop_height, crop_x, crop_y)
      image = MiniMagick::Image.new(path_to_image)
      image.crop("#{crop_width}x#{crop_height}+#{crop_x}+#{crop_y}")
    end
  end
end
