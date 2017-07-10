class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo, :rating
end
