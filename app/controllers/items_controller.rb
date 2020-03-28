class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    
    if params[:sort1].present?
      @items = Item.order(params[:sort1]+" DESC")
    elsif params[:sort2].present?
      @items = Item.order(params[:sort2])
    elsif params[:category].present?
      @category = Category.all
      @items = Item.where(Category: params[:category])
    elsif params[:brand].present?
      @category = Category.all
      @items = Item.where(Brand: params[:brand])
    elsif params[:availability].present?
      @category = Category.all
      @items = Item.where(Availability: params[:availability])
    else
      @items = Item.all
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id].to_i)
  end

  def subscription
    @user = User.find(params[:user_id])
    @item = Item.find(params[:item_id])
    UserSubscriptionMailer.with(user: @user, item: @item).subscription_email.deliver_now!
  end

  # # GET /items/new
  def new
    @item = Item.new
  end

  # # GET /items/1/edit
  def edit
  end

  # # POST /items
  # # POST /items.json
  def create
    @item = Item.new(item_params)
    if @item.Quantity > 0 
      @item.Availability = true
    end
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /items/1
  # # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /items/1
  # # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:Unique_ID, :Brand, :Name, :Category, :Restricted_item, :Age_restricted_item, :Quantity, :Cost, :Tax_Slab, pictures: [])
    end
end
