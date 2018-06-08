class Api::V1::ArticlesController < Api::V1::BaseController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    if params[:page]
      @article = Article.page(params[:page]).per(5)
    else
      @article = Article.order('updated_at DESC')
    end

    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::CollectionSerializer.new(@article, each_serializer: ArticleSerializer)},status: 200
  end

  # GET /articles/1
  def show
    render json: {
      status: '200',
      message: 'OK',
      data: ActiveModel::Serializer::ArticleSerializer.new(@article).as_json},status: 200
  end

  # PUT /articles/1
  def update
    if @article.update(article_params)
      render json: { status: '200', message: 'OK', data: @article }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @article.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.where(id: params[:id]).first
    if @article.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  # POST /products/ "json"
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: { status: '200', message: 'OK', data: @article }, status: :ok
    else
      render json: { status: '400', message: 'Bad Request', data: @article.errors }, status: :unprocessable_entity
    end
  end

  private

  # User callback to share common setup or constraints betwen actions
  def set_article
    @article = Article.find(params[:id])
  end

  # only allow a trusted paramater "white list" through
  def article_params
    params.require(:article).permit(:category_id, :title, :content, :image, :reff_link)
  end
end
