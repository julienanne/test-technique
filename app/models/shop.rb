class Shop < ApplicationRecord
  has_many :products, dependent: :delete_all
  has_and_belongs_to_many :taxons

  scope :available, -> { where(available_on: ..DateTime.now)}  
end
