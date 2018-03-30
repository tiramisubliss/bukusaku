class V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  def index
    @article = Article.all
    render json: @article, status: :ok
  end

  def show
    render json: @article, status: :ok 
  end

  # Get articles/1
  def update
    if @article.update(article_params)
      render json: @article, status: :ok
    else
      render json: { errors: @article.errors}, status: :unprocessable_entity
    end
  end

  # Get articles/1
  def destroy
    @article = Article.where(id: params[:id]).first
    if @article.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end  

  def create
    @article = Article.new(article_params)

  	if @article.save
  		render json: @article, status: :created
  	else
  		render json: { errors: @article.errors }, status: :unprocessable_entity
  	end
  end

  private

  def set_article
  	@article = Article.find(params[:id])
  end

  def article_params
  	params.require(:article).permit(:category_id, :title, :content, :image, :reff_link)
  end
end
