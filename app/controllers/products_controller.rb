class ProductsController < ShopifyApp::AuthenticatedController
  around_filter :shopify_session

  def index
    if params[:id]
      @products = ShopifyAPI::Product.find(:all, params: {page: params[:id], limit: 250})
    else
      @products = ShopifyAPI::Product.find(:all, params: {limit: 250})
    end

    @page_num = params[:id].to_i
  end

  def edit
  end

  def update
    product = ShopifyAPI::Product.find(params[:id])
    puts product.tags

    puts "Lighting Closeouts: #{true_or_false(params[:lightingcloseouts])}"
    puts "Lights4Less4U: #{true_or_false(params[:lights4less4u])}"
    puts "Hide on QDL: #{true_or_false(params[:qdl])}"

    if params[:lightingcloseouts]
      if product.tags.include? 'lightingcloseouts__hide'
        tags_gsub(product.tags, 'lightingcloseouts__hide', 'lightingcloseouts__show')
      else
        product.tags = product.tags + ', lightingcloseouts__show'
      end
    else
      if product.tags.include? 'lightingcloseouts__show'
        tags_gsub(product.tags, 'lightingcloseouts__show', 'lightingcloseouts__hide')
      else
        product.tags = product.tags + ', lightingcloseouts__hide'
      end
    end

    if params[:lights4less4u]
      if product.tags.include? 'lights4less4u__hide'
        tags_gsub(product.tags, 'lights4less4u__hide', 'lights4less4u__show')
      else
        product.tags = product.tags + ', lights4less4u__show'
      end
    else
      if product.tags.include? 'lights4less4u__show'
        tags_gsub(product.tags, 'lights4less4u__show', 'lights4less4u__hide')
      else
        product.tags = product.tags + ', lights4less4u__hide'
      end
    end

    if params[:qdl]
      if product.tags.include? 'qdlhome__show'
        tags_gsub(product.tags, 'qdlhome__show', 'qdlhome__hide')
      else
        product.tags = product.tags + ', qdlhome__hide'
      end
    else
      if product.tags.include? 'qdlhome__hide'
        tags_gsub(product.tags, 'qdlhome__hide', 'qdlhome__show')
      else
        product.tags = product.tags + ', qdlhome__show'
      end
    end

    product.save

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

  def tags_gsub(tags, search_for, replace_with)
    tags.gsub!(search_for, replace_with) if tags.split(", ").include? search_for
    return tags
  end

end
