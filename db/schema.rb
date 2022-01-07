# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220105175051) do

  create_table "activacionclientets", force: :cascade do |t|
    t.string   "email"
    t.string   "clienteid"
    t.string   "tipocliente"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "aliasmodelosiglasorteots", force: :cascade do |t|
    t.string   "nombre"
    t.string   "siglasorteo"
    t.string   "modeloventaq"
    t.string   "modelocontrolq"
    t.string   "modeloventap"
    t.string   "modelocontrolp"
    t.string   "modeloventat"
    t.string   "modelocontrolt"
    t.string   "modeloventasp"
    t.string   "modelocontrolsp"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "ciudadts", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "provinciat_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["provinciat_id"], name: "index_ciudadts_on_provinciat_id"
  end

  create_table "colectorts", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "cedula"
    t.string   "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coliseots", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "consorciots", force: :cascade do |t|
    t.string   "nombre"
    t.string   "abreviatura"
    t.string   "telefono"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "continentets", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "controldepagogts", force: :cascade do |t|
    t.string   "tipojugada"
    t.string   "limitexticket"
    t.string   "limiteglobal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "controlpgmts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpleits", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpltkts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpnnts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpnynts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpnytts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlpreats", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqgmts", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqleits", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqltkts", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqnnts", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqnynts", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqnytts", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlqreats", force: :cascade do |t|
    t.integer  "numero"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlspleinnts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlspltknnts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlspnnts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controlspreannts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltgmts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltleits", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltltkts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltnnts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltnynts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltnytts", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controltreats", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "limite"
    t.integer  "vendida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ganadorests", force: :cascade do |t|
    t.integer  "sorteot_id"
    t.datetime "fecha"
    t.integer  "primero"
    t.integer  "segundo"
    t.integer  "tercero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sorteot_id"], name: "index_ganadorests_on_sorteot_id"
  end

  create_table "gppts", force: :cascade do |t|
    t.string   "nombre"
    t.string   "q1"
    t.string   "q2"
    t.string   "q3"
    t.string   "p12"
    t.string   "p13"
    t.string   "p23"
    t.string   "sp"
    t.string   "t123"
    t.string   "t13"
    t.string   "t23"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horariosorteots", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "lunes"
    t.datetime "martes"
    t.datetime "miercoles"
    t.datetime "jueves"
    t.datetime "viernes"
    t.datetime "sabado"
    t.datetime "domingo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impresionts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.text     "jugadas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_impresionts_on_ticket_id"
  end

  create_table "jugadalots", force: :cascade do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.integer  "monto"
    t.string   "qpt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "ticket_id"
    t.integer  "sorteot_id"
    t.string   "comandojugada"
    t.string   "pelea"
    t.string   "apuestacinta"
    t.string   "ml"
    t.string   "posiblepago"
    t.string   "acierto"
    t.string   "resultado"
    t.string   "pagoreal"
    t.index ["sorteot_id"], name: "index_jugadalots_on_sorteot_id"
    t.index ["ticket_id"], name: "index_jugadalots_on_ticket_id"
  end

  create_table "lineatprints", force: :cascade do |t|
    t.string   "coliseo"
    t.string   "bloque"
    t.string   "pelea"
    t.string   "azul"
    t.string   "mla"
    t.string   "blanco"
    t.string   "mlb"
    t.string   "time"
    t.string   "under"
    t.string   "over"
    t.string   "status"
    t.string   "ganador"
    t.string   "tfinal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lineats", force: :cascade do |t|
    t.string   "coliseo"
    t.string   "bloque"
    t.string   "pelea"
    t.string   "azul"
    t.string   "blanco"
    t.string   "mla"
    t.string   "mlb"
    t.string   "tiempoml"
    t.string   "oua"
    t.string   "oub"
    t.string   "status"
    t.string   "resultado"
    t.string   "tiempofinalizado"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "loteriats", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "paist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["paist_id"], name: "index_loteriats_on_paist_id"
  end

  create_table "manageuserbts", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "modificadopor"
    t.boolean  "activo"
    t.string   "telefono"
    t.string   "sucursal"
    t.string   "tipousuario"
    t.string   "consorcio"
    t.string   "sucursalbt"
    t.string   "siglas"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "provincia"
    t.string   "zona"
    t.string   "vendedor"
    t.string   "contacto"
    t.string   "supervisor"
    t.string   "colector"
    t.string   "socio"
    t.string   "gppt"
  end

  create_table "mensajepiedepaginats", force: :cascade do |t|
    t.string   "tipodemensaje"
    t.string   "mensaje"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "menuadmrresultadoglobalts", force: :cascade do |t|
    t.date     "desde"
    t.date     "hasta"
    t.string   "sucursal"
    t.integer  "venta"
    t.integer  "ganadores"
    t.integer  "balance"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "pendientexpagar"
  end

  create_table "menuadmrresultadoglobalxsupervisorts", force: :cascade do |t|
    t.date     "desde"
    t.date     "hasta"
    t.string   "supervisor"
    t.integer  "venta"
    t.integer  "ganadores"
    t.integer  "balance"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "sucursal"
    t.string   "pendientexpagar"
  end

  create_table "menuadmticketsganadoresxfechats", force: :cascade do |t|
    t.string   "sucursal"
    t.date     "desde"
    t.date     "hasta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menuf10ts", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "sorteot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sorteot_id"], name: "index_menuf10ts_on_sorteot_id"
  end

  create_table "menuposrventadiaactualts", force: :cascade do |t|
    t.string   "sucursal"
    t.date     "fecha"
    t.string   "venta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menuposrventaxfechats", force: :cascade do |t|
    t.string   "sucursal"
    t.date     "desde"
    t.date     "hasta"
    t.string   "venta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menuts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monedats", force: :cascade do |t|
    t.string   "simbolo"
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "paist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["paist_id"], name: "index_monedats_on_paist_id"
  end

  create_table "paists", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "continentet_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["continentet_id"], name: "index_paists_on_continentet_id"
  end

  create_table "provinciats", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "paist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paist_id"], name: "index_provinciats_on_paist_id"
  end

  create_table "recordpgmts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpgmts_on_ticket_id"
  end

  create_table "recordpleits", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpleits_on_ticket_id"
  end

  create_table "recordpltkts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpltkts_on_ticket_id"
  end

  create_table "recordpnnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpnnts_on_ticket_id"
  end

  create_table "recordpnynts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpnynts_on_ticket_id"
  end

  create_table "recordpnytts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpnytts_on_ticket_id"
  end

  create_table "recordpreats", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordpreats_on_ticket_id"
  end

  create_table "recordqgmts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqgmts_on_ticket_id"
  end

  create_table "recordqleits", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqleits_on_ticket_id"
  end

  create_table "recordqltkts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqltkts_on_ticket_id"
  end

  create_table "recordqnnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqnnts_on_ticket_id"
  end

  create_table "recordqnynts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqnynts_on_ticket_id"
  end

  create_table "recordqnytts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqnytts_on_ticket_id"
  end

  create_table "recordqreats", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordqreats_on_ticket_id"
  end

  create_table "recordspleinnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordspleinnts_on_ticket_id"
  end

  create_table "recordspltknnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordspltknnts_on_ticket_id"
  end

  create_table "recordspnnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordspnnts_on_ticket_id"
  end

  create_table "recordspreannts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_recordspreannts_on_ticket_id"
  end

  create_table "recordtgmts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtgmts_on_ticket_id"
  end

  create_table "recordtleits", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtleits_on_ticket_id"
  end

  create_table "recordtltkts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtltkts_on_ticket_id"
  end

  create_table "recordtnnts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "seleccionada"
    t.index ["ticket_id"], name: "index_recordtnnts_on_ticket_id"
  end

  create_table "recordtnynts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtnynts_on_ticket_id"
  end

  create_table "recordtnytts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtnytts_on_ticket_id"
  end

  create_table "recordtreats", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "n3"
    t.string   "siglas"
    t.integer  "monto"
    t.string   "seleccionada"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ticket_id"], name: "index_recordtreats_on_ticket_id"
  end

  create_table "sociots", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sorteots", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "sigla"
    t.integer  "horariosorteot_id"
    t.integer  "loteriat_id"
    t.string   "activo"
    t.string   "abierto"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "abreviaturamovil"
    t.index ["horariosorteot_id"], name: "index_sorteots_on_horariosorteot_id"
    t.index ["loteriat_id"], name: "index_sorteots_on_loteriat_id"
  end

  create_table "sucursalts", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "supervisorts", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "cedula"
    t.string   "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supservisorts", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "cedula"
    t.string   "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "serial"
    t.integer  "user_id"
    t.string   "activo"
    t.string   "ganador"
    t.string   "pago"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "fechaimpresion"
    t.string   "pagadopor"
    t.string   "latitud"
    t.string   "longitud"
    t.string   "parlay"
    t.string   "pagoreal"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "ticketsganadorests", force: :cascade do |t|
    t.integer  "ticket_id"
    t.string   "jugada"
    t.integer  "montoapostado"
    t.integer  "montoacobrar"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "grupoprocesado"
    t.string   "sucursal"
    t.string   "sorteo"
    t.date     "fechasorteo"
    t.index ["ticket_id"], name: "index_ticketsganadorests_on_ticket_id"
  end

  create_table "tipousuariots", force: :cascade do |t|
    t.string   "tipo_usuario"
    t.string   "descripcion"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "trabats", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "telefono"
    t.integer  "sucursalt_id"
    t.integer  "tipousuariot_id"
    t.boolean  "activo"
    t.integer  "consorciot_id"
    t.string   "sucursalbt"
    t.string   "siglas"
    t.string   "direccion"
    t.integer  "ciudadt_id"
    t.integer  "provinciat_id"
    t.integer  "zonat_id"
    t.string   "vendedor"
    t.string   "contacto"
    t.integer  "supervisort_id"
    t.integer  "colectort_id"
    t.integer  "sociot_id"
    t.integer  "gppt_id"
    t.index ["ciudadt_id"], name: "index_users_on_ciudadt_id"
    t.index ["colectort_id"], name: "index_users_on_colectort_id"
    t.index ["consorciot_id"], name: "index_users_on_consorciot_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["gppt_id"], name: "index_users_on_gppt_id"
    t.index ["provinciat_id"], name: "index_users_on_provinciat_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sociot_id"], name: "index_users_on_sociot_id"
    t.index ["sucursalt_id"], name: "index_users_on_sucursalt_id"
    t.index ["supervisort_id"], name: "index_users_on_supervisort_id"
    t.index ["tipousuariot_id"], name: "index_users_on_tipousuariot_id"
    t.index ["zonat_id"], name: "index_users_on_zonat_id"
  end

  create_table "zonats", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
