class V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  #GET /articles
  def index
    @article = Article.all
    render json: @article, status: :ok
  end

  #GET /articles/1
  def show
    render json: @article, status: :ok 
  end

  #PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article, status: :ok
    else
      render json: { errors: @article.errors}, status: :unprocessable_entity
    end
  end

  #DELETE /articles/:id
  def destroy
    @article = Article.where(id: params[:id]).first
    if @article.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end  

  #POST /articles/ "json"
  def create
    @article = Article.new(article_params)

  	if @article.save
  		render json: @article, status: :created
  	else
  		render json: { errors: @article.errors }, status: :unprocessable_entity
  	end
  end

  private
  #User callback to share common setup or constraints betwen actions
  def set_article
  	@article = Article.find(params[:id])
  end

  #only allow a trusted paramater "white list" through
  def article_params
  	params.require(:article).permit(:category_id, :title, :content, :image, :reff_link)
  end
end
