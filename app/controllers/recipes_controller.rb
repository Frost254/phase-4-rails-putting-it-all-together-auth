class RecipesController < ApplicationController
  before_action :authorize

  def index
    render json: Recipe.all, status: :ok
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create!(recipe_params)
    render json: recipe, status: 201
  end

  private

  def authorize
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless session[:user_id]
  end

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
