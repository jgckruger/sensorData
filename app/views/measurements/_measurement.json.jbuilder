json.extract! measurement, :id, :temperature, :humidity, :lightLevel, :device_id, :created_at, :updated_at
json.url measurement_url(measurement, format: :json)
