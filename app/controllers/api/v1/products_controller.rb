class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def create
    product = current_user.products.build(product_params)
    if product.save
      render json: product, status: 200, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def update
    product = current_user.products.find(params[:id])
    if product.update_attributes(product_params)
      render json: product, status: 200, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def show
    respond_with Product.find(params[:id])
  end

  def index
    respond_with Product.self(params)
  end

  private
  def product_params
    params.require(:product).permit(:title, :price, :published)
  end
end
