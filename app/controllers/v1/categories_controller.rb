class V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  #GET /categories/
  def index
    @category = Category.all
    render json: @category, status: :ok
  end

  #GET /categories/1
  def show
    category = Category.find(params[:id])

    #render json: @category.products
    render json: @category, status: :ok 
  end

  #PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors}, status: :unprocessable_entity
    end
  end

   #DELETE /categories/:id
  def destroy
    @category = Category.where(id: params[:id]).first
    if @category.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end  

  #POST /categories/ "json"
  def create
    @category = Category.new(category_params)

  	if @category.save
  		render json: @category, status: :created
  	else
  		render json: { errors: @category.errors }, status: :unprocessable_entity
  	end
  end

  #GET /categories/search/:name
  def search_category
    @product = Product.select("products.*, categories.category_name").joins(:category).where("categories.category_name ilike ?", "%#{params[:name]}%")

    render json: @product, status: :ok
  end

  private
  #User callback to share common setup or constraints betwen actions
  def set_category
  	@category = Category.find(params[:id])
  end

  #only allow a trusted paramater "white list" through
  def category_params
  	params.require(:category).permit(:category_name, :status)
  end
end
