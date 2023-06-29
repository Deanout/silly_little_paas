json.extract! container, :id, :name, :port, :container_name, :created_at, :updated_at
json.url container_url(container, format: :json)
