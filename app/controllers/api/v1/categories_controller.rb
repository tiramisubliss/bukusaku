class Api::V1::CategoriesController < Api::V1::BaseController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories/
  def index
    if params[:page]
      @category = Category.page(params[:page]).per(5)
    else
      @category = Category.order('updated_at DESC')
    end
    render json: {
      status: '200',
      message: 'OK',
      #data: ActiveModel::Serializer::CollectionSerializer.new(@category, each_serializer: CategorySerializer)}, status: 200
      data: @category }, status: 200
  end

  # GET /categories/1
  def show
    render json: {
      status: '200',
      message: 'OK',
      #data: ActiveModel::Serializer::CategorySerializer.new(@category).as_json}, status: 200
      data: @category }, status: 200

  end

  # PUT /categories/1
  def update
    if @category.update(category_params)
      render json: { status: '200', message: 'OK', data: @category }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @category.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    @category = Category.where(id: params[:id]).first
    if @category.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  # POST /categories/ "json"
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: { status: '200', message: 'OK', data: @category }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @category.errors }, status: :unprocessable_entity
    end
  end

  # GET /categories/search/:name
  def search_category
    @product = Product.select("products.*, categories.category_name").joins(:category).where("categories.category_name ilike ?", "%#{params[:name]}%")
    render json: { status: '200', message: 'OK', data: @product }, status: :ok
  end

  private
  # User callback to share common setup or constraints betwen actions
  def set_category
    @category = Category.find(params[:id])
  end

  # only allow a trusted paramater "white list" through
  def category_params
    params.require(:category).permit(:category_name, :hex_color, :icon)
  end
end
