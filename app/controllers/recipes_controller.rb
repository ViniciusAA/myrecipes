class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash_message("created")
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      flash_message("updated")
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def show; end

  def destroy
    @recipe.destroy
    flash_message("deleted")
    redirect_to recipes_path
  end

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def flash_message(action)
    flash[:success] = "Recipe " + action + " successfully!"
  end
end
