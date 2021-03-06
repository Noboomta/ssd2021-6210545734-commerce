class Product < ApplicationRecord

  validates :name, length: { minimum: 4 }
  validates :description, length: { minimum: 4 }
  validate :non_negative
  belongs_to :category
  
  def non_negative
    if stock.negative?()
      errors.add(:stock, 'cannot be negative')
    end
  end
end