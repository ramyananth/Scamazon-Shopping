json.extract! item, :id, :Unique_ID, :Brand, :Name, :Category, :Restricted_item, :Age_restricted_item, :Quantity, :Cost, :Tax_Slab, :created_at, :updated_at
json.url item_url(item, format: :json)
