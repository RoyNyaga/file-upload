class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :houses

  validate :acceptable_image

  private

  def acceptable_image
    return unless avatar.attached?
  
    unless avatar.byte_size <= 6.megabyte
      errors.add(:avatar, "is too big")
    end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG or PNG")
    end
  end
end
