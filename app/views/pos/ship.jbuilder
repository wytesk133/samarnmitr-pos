#TODO: don't show item that shipped 0
json.array! @ship do |key, value|
  json.id key
  json.quantity value
end
