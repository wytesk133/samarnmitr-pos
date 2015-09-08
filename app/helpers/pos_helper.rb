module PosHelper
  def product_name(id)
    Product.find(id).name;
  end
end
