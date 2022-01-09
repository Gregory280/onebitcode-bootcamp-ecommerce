class Product < ApplicationRecord
  belongs_to :productable, polymorphic: true
  has_one_attached :image
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :image, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  include NameSearchable
  include Paginatable
end
