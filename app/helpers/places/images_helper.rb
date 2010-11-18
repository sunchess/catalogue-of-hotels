module Places::ImagesHelper
  def draft?(image)
    image.draft? ? "draft tooltips" : nil
  end
end
