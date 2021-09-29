class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item
  belongs_to :status
  belongs_to :shopping_charge
  belongs_to :area
  belongs_to :days

end
