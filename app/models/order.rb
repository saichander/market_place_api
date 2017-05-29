class Order < ApplicationRecord
  belongs_to :user

  has_many :placements
  has_many :products, through: :placements

  validates :total, presence: true,
    numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_total!
  validates :user_id, presence: true

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity

      self.placements.build(product_id: id)
    end
  end
  private
  def set_total!
    self.total = products.map(&:price).sum
  end
end
