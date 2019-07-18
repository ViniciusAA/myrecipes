class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :show, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to Myrecipes app!"
      session[:chef_id] = @chef.id
      redirect_to @chef
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @chef
    else
      render "edit"
    end
  end

  def destroy
    session[:chef_id] = nil if @chef == current_chef
    @chef.destroy
    flash[:danger] = "Chef and all associated recipes have been deleted!"
    redirect_to chefs_path
  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  private

  def require_same_user
    if current_chef != @chef && !current_chef.admin?
      flash[:danger] = "You can only delete or edit your own profile"
      redirect_to chefs_path
    end
  end

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end
end
