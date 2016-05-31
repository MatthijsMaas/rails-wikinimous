class ArticlesController < ApplicationController
 def index
 renderer = Redcarpet::Render::HTML.new(escape_html: true)
    @articles = Article.all
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})

  end

  def show
    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    @article = Article.find(params[:id])
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    if @article.save
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
