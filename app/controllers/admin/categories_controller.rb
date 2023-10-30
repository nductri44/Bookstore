class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
    @category.parent_category = Category.find(params[:id]) unless params[:id].nil?
  end

  def show
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Create category success.'
      redirect_to(root_url)
    else
      render('new')
    end
  end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name, :description, :parent_id)
  end
end
