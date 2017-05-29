class Placement < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_create :decrement_product_quantity!
  private
  def decrement_product_quantity!
    self.product.decrement!(:quantity, quantity)
  end
end
