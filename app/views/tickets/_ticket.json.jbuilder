json.extract! ticket, :id, :serial, :user_id, :fechaimpresion, :activo, :ganador, :pago, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
