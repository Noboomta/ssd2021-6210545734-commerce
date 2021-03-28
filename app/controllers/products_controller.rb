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
    @product = Product.new 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.invalid?
      # flash[:error] = @products.errors.objects.first.full_message
    end
    if @product.save
      flash[:success] = "Product created"
    end

    redirect_to action: :index
  end

  def update
    @product.category_id = params[:category_id]
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  def product_params
    params.require(:product).permit(:name, :description, :stock)
  end
end