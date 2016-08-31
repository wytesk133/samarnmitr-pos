json.array!(@combos) do |combo|
  json.extract! combo, :id, :name, :price
  json.products JSON.parse(combo.products)
end
