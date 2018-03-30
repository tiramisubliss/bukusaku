class V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @category = Category.all
    render json: @category, status: :ok
  end

  def show
    render json: @category, status: :ok 
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.where(id: params[:id]).first
    if @category.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end  

  def create
    @category = Category.new(category_params)

  	if @category.save
  		render json: @category, status: :created
  	else
  		render json: { errors: @category.errors }, status: :unprocessable_entity
  	end
  end

  private

  def set_category
  	@category = Category.find(params[:id])
  end

  def category_params
  	params.require(:category).permit(:category_name, :status)
  end
end
