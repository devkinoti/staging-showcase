class OrdersController < ApplicationController
  before_action :authenticate_user!
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  # GET /orders
  # GET /orders.json
  def index
    #@orders = Order.all.order("created_at DESC")
    @orders = Order.all.paginate(:page => params[:page],:per_page => 15).order("created_at DESC")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = OrderPdf.new(@order,view_context)
        send_data pdf.render,:filename => "order_#{@order.id}",
                             :type => "application/pdf"
      end
    end   
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "The cart is empty"
      return
    end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        # Product.calculate_stock_quantity(@order)
        #check here
        #Product.remove_from_stock(@order) 
        format.html { redirect_to @order, notice: 
          'Order created successfully.' }
        format.json { render action: 'show', status: :created,
          location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors,
          status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update_attributes(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    Order.import(params[:file])
    redirect_to import_url, notice: "Orders Imported successfully"
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The order you were looking for does not exist"
      redirect_to orders_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:paid,:cash_paid)
    end


  #...
end
