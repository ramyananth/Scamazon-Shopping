class CartsController < ApplicationController
  # before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  # def index
  #   @carts = Cart.all
  # end

  # GET /carts/1
  # GET /carts/1.json

  # def show
  #   if current_user
  #     @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
  #   end
  # end

  # GET /carts/new
  # def new
  #   @cart = Cart.new
  # end

  # GET /carts/1/edit
  # def edit
  # end

  # POST /carts
  # POST /carts.json
  # def create
  #   @cart = Cart.new(cart_params)

  #   respond_to do |format|
  #     if @cart.save
  #       format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
  #       format.json { render :show, status: :created, location: @cart }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  # def update
  #   respond_to do |format|
  #     if @cart.update(cart_params)
  #       format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @cart }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /carts/1
  # DELETE /carts/1.json
  # def destroy
  #   @cart.destroy
  #   respond_to do |format|
  #     format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_cart
  #     @cart = Cart.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def cart_params
  #     params.require(:cart).permit(:user_id)
  #   end

  # def clear_all
  #   @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
  #   @cart.each do |cart_item|
  #     cart_item.delete
  #   end
  #   @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
  #   render '/carts/show'
  # end

  before_action :authenticate_user! 

  def show 
    @cart_items_with_qty = current_user.get_cart_items_with_qty
    if current_user.cart_total_price 
      if current_user.cart_total_price > 0
        @cart_total = current_user.cart_total_price
      else
        @cart_total = 0
      end
    end
  end 

  def add 
    current_user.add_to_cart(params[:item_id])
    redirect_to carts_path
  end 

  def remove 
    current_user.remove_from_cart(params[:item_id])
  end

  def removeone 
    current_user.remove_one_from_cart(params[:item_id])
    redirect_to carts_path
  end

end
