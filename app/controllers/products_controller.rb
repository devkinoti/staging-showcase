class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!,only: [:destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @search = Product.search(params[:q])
    @products = @search.result.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC")
    @total_sum = Product.sum("quantity * purchase_price")
    @csv_products = Product.all.order("created_at DESC")

    respond_to do |format|
      format.html
      format.csv { send_data @csv_products.to_csv, :filename => "products-#{Time.current.strftime("%d-%b-%Y")}.csv"}
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "#{@product.name} was successfully created."}
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "#{@product.name} was successfully updated."}
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    Product.import(params[:file])
    redirect_to products_url, notice: "Products Imported successfully"
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The product you were looking for does not exist"
      redirect_to products_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name,:quantity,:units,:product_type,:purchase_price,:shop_price,:mass_unit_check)
    end
end
