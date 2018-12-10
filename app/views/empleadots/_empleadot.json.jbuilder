json.extract! empleadot, :id, :nombre, :apellido, :cedula, :telefono, :created_at, :updated_at
json.url empleadot_url(empleadot, format: :json)
