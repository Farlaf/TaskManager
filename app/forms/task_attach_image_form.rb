class TaskAttachImageForm
  include ActiveModel::Validations
  include Virtus.model

  attribute :image, ActionDispatch::Http::UploadedFile
  attribute :crop_width, Integer
  attribute :crop_height, Integer
  attribute :crop_x, Integer
  attribute :crop_y, Integer

  with_options numericality: { only_integer: true, greater_than_or_equal_to: 0 } do
    validates :crop_width, if: -> { crop_width.present? }
    validates :crop_height, if: -> { crop_height.present? }
    validates :crop_x, if: -> { crop_x.present? }
    validates :crop_y, if: -> { crop_y.present? }
  end

  validates :image, presence: true,
                    file_size: { less_than_or_equal_to: 2.megabytes },
                    file_content_type: { allow: ['image/jpeg', 'image/png'] }

  def processed_image
    ImageProcessingService.crop!(image.path, crop_width, crop_height, crop_x, crop_y) if cropping?

    image
  end

  def cropping?
    [crop_width, crop_height, crop_x, crop_y].all?(&:present?)
  end
end
