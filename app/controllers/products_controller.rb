class ProductsController < ShopifyApp::AuthenticatedController
  around_filter :shopify_session

  def index
    @products = ShopifyAPI::Product.all
  end

  def update
    @product = ShopifyAPI::Product.find(params[:id])
    puts @product.tags
    # @product.tags = @product.tags
    # @product.save
    puts "Lighting Closeouts: #{true_or_false(params[:lightingcloseouts])}"
    puts "Lights4Less4U: #{true_or_false(params[:lights4less4u])}"
    puts "Hide on QDL: #{true_or_false(params[:qdl])}"

    redirect_to '/'
  end

  private

  def true_or_false(binary)
    if binary == nil
      return false
    else
      return true
    end
  end

end
