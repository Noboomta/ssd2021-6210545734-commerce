class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:create,:edit,:destroy]
  
  def index
    @search = params[:search]

    @products = Product.all
    @products = @products
      .where("title LIKE ? or body LIKE ?", "%#{@search}%", "%#{@search}%") if @search.present?
    @products = @products.page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    puts "This is how you print out something."
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create(product_params)

    if @product.invalid?
      flash[:error] = @product.errors.full_messages
    end

    redirect_to action: :index
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :stock)
  end
end