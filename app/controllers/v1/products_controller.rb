class V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  #GET /products/
  def index
    @product = Product.all
    render json: @product, status: :ok 
  end

  #GET /products/1
  def show
  	render json: @product, status: :ok
  end

  #DELETE /products/:id
  def destroy
    @product = Product.where(id: params[:id]).first
    if @product.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  #PUT /products/1
  def update
  	if @product.update(product_params)
  	  render json: @product, status: :ok
  	else
  	  render json: { errors: @product.errors}, status: :unprocessable_entity
  	end
  end

  #POST /products/ "json"
  def create
    @product = Product.new(product_params)

  	if @product.save
  	  render json: @product, status: :created
  	else
  	  render json: { errors: @product.errors}, status: :unprocessable_entity
  	end
  end

  #GET /products/search/:name
  def search_product
      @product = Product.joins(:category).where("products.product_name ilike ?", "%#{params[:name]}%")
      render json: @product, status: :ok
  end

  private 
  #User callback to share common setup or constraints betwen actions
  def set_product
  	@product = Product.find(params[:id])
  end

  #only allow a trusted paramater "white list" through
  def product_params
  	params.require(:product).permit(:category_id, :product_name, :company, :description, :logo_img, :cover_img, :web_link, :gplay_link)
  end
end