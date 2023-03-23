class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
   user = User.find_by(id: session[:user_id])
   if user
    render json: user
   else
    render json: {error: "Not logged in"}, status: :unauthorized
   end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
