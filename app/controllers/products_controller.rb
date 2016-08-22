class ProductsController < ShopifyApp::AuthenticatedController
  around_filter :shopify_session

  def index
    if params[:id]
      @products = ShopifyAPI::Product.find(:all, params: {page: params[:id], limit: 250})
      @page_num = params[:id].to_i
    else
      @products = ShopifyAPI::Product.find(:all, params: {limit: 250})
      @page_num = 1
    end

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
      product.tags = product.tags + ', lightingcloseouts__show'
    else
      tags_gsub(product.tags, 'lightingcloseouts__show', '')
    end

    if params[:lcfans]
      product.tags = product.tags + ', lightingcloseouts__fans'
    else
      tags_gsub(product.tags, 'lightingcloseouts__fans', '')
    end

    if params[:lcres]
      product.tags = product.tags + ', lightingcloseouts__res'
    else
      tags_gsub(product.tags, 'lightingcloseouts__res', '')
    end

    if params[:lccom]
      product.tags = product.tags + ', lightingcloseouts__comm'
    else
      tags_gsub(product.tags, 'lightingcloseouts__comm', '')
    end

    if params[:lcparts]
      product.tags = product.tags + ', lightingcloseouts__parts'
    else
      tags_gsub(product.tags, 'lightingcloseouts__parts', '')
    end

    if params[:lcbulbs]
      product.tags = product.tags + ', lightingcloseouts__bulbs'
    else
      tags_gsub(product.tags, 'lightingcloseouts__bulbs', '')
    end


    if params[:lights4less4u]
      product.tags = product.tags + ', lights4less4u__show'
    else
      tags_gsub(product.tags, 'lights4less4u__show', '')
    end

    if params[:qdl]
      product.tags = product.tags + ', qdlhome__hide'
    else
      tags_gsub(product.tags, 'qdlhome__hide', '')
    end

    product.save

    redirect_to :back
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
