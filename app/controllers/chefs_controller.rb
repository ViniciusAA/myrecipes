class ChefsController < ApplicationController
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to Myrecipes app!"
      redirect_to @chef
    else
      render "new"
    end
  end

  def edit
    set_chef
  end

  def update
    set_chef
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @chef
    else
      render "edit"
    end
  end

  def destroy
    set_chef
    @chef.destroy
    flash[:success] = "Your account was deleted successfully!"
    redirect_to pages_home_path
  end

  def show
    set_chef
  end

  def index
    @chefs = Chef.all
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end
end
