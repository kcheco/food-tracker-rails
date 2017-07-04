class Meal < ApplicationRecord
  # validation rules
  validates :name, presence: true, length: { minimum: 2,
                                             maximum: 50
                                           }
  validates :rating, presence: true, numericality: { only_integer: true,
                                                     greater_than_or_equal_to: 0,
                                                     less_than_or_equal_to: 5
                                                   }
end
