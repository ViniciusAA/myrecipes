class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
    select_recipe
  end

  def update
    select_recipe
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def show
    select_recipe
  end

  def destroy
    select_recipe
    @recipe.destroy
    flash[:success] = "Recipe deleted successfully!"
    redirect_to recipes_path
  end

  def index
    @recipes = Recipe.all
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end

  def select_recipe
    @recipe = Recipe.find(params[:id])
  end
end
