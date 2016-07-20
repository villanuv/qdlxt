class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.all
  end
end
