class V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    if params[:category].blank?
     @product = Product.all.order("created_at DESC")
     render json: @product
    else
      @category_id = Category.find_by(category_name: params[:category_name]).id
      @product = Product.where(category_id: @category_id).order("created_at DESC")

    render json: @product, status: :ok 
    end

    #@product = Product.all
    #render json: @product, status: :ok 
  end


  def search
    @category = Category.where(category_name: params[:category_name]).id
    @product = Product.where(category_id: @category).order("created_at DESC")
    
    # product.map do |val|
    #   {
    #     id: val.id,
    #     name: val.name,
    #   }
     
    render json: @product, status: :ok
  end

  def show
  	render json: @product, status: :ok
  end

  def destroy
    @product = Product.where(id: params[:id]).first
    if @product.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def update
  	if @product.update(product_params)
  	  render json: @product, status: :ok
  	else
  	  render json: { errors: @product.errors}, status: :unprocessable_entity
  	end
  end

  def create
    @product = Product.new(product_params)

  	if @product.save
  	  render json: @product, status: :created
  	else
  	  render json: { errors: @product.errors}, status: :unprocessable_entity
  	end
  end

  private 

  def set_product
  	@product = Product.find(params[:id])
  end

  def product_params
  	params.require(:product).permit(:category_id, :product_name, :company, :description, :logo_img, :cover_img, :web_link, :gplay_link)
  end
end