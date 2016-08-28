module PosHelper
  def product_name(id)
    Product.find(id).name
  end

  def product_price(id)
    Product.find(id).price
  end

  def combo_name(id)
    Combo.find(id).name
  end

  def combo_price(id)
    Combo.find(id).price
  end

  def combo_items(combo_id, selected)
    items = JSON.parse(Combo.find(combo_id).products)
    idx = 0
    result = []
    items.each do |item|
      if item.kind_of?(Array)
        result.push(product_name(item[selected[idx]]))
        idx += 1
      else
        result.push(product_name(item))
      end
    end
    result
  end
end
