class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products/
  def index
    if params[:page]
      @product = Product.page(params[:page]).per(5)
    else
      @product = Product.order('updated_at DESC')
    end

    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::CollectionSerializer.new(@product, each_serializer: ProductSerializer)},status: 200
  end

  # GET /products/1
  def show
    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::ProductSerializer.new(@product).as_json},status: 200
  end

  # DELETE /products/:id
  def destroy
    @product = Product.where(id: params[:id]).first
    if @product.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  # PUT /products/1
  def update
    if @product.update(product_params)
      render json: { status: '200', message: 'OK', data: @product }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @product.errors }, status: :unprocessable_entity
    end
  end

  # POST /products/ "json"
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: { status: '200', message: 'OK', data: @product }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @product.errors }, status: :unprocessable_entity
    end
  end

  # GET /products/search/:name
  def search_product
    @product = Product.joins(:category)
                      .where("products.product_name ilike ?", "%#{params[:name]}%")
    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::CollectionSerializer.new(@product, each_serializer: ProductSerializer)},status: 200
  end

  private

  # User callback to share common setup or constraints betwen actions
  def set_product
    @product = Product.find(params[:id])
  end

  # only allow a trusted paramater "white list" through
  def product_params
    params.require(:product).permit(:category_id,                                   
                                    :product_name,
                                    :company,
                                    :description,
                                    :logo_img,
                                    :web_link,
                                    :gplay_link,
                                    )
  end
end
