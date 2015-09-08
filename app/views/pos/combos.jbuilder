json.array!(@combos) do |combo|
  json.extract! combo, :id, :name, :price
  products = JSON.parse(combo.products)
  json.products products do |product|
    if product.kind_of?(Array)
      choices = product #for better code understanding
      json.type "choice"
      json.choices choices do |id|
        json.id id
        json.name product_name(id) #product_name is a method in POSHelper
      end
    else
      id = product #for better code understanding
      json.type "item"
      json.id id
      json.name product_name(id) #product_name is a method in POSHelper
    end
   end
end
