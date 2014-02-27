# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140227124513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aulaabierta", force: true do |t|
    t.date    "fin"
    t.date    "inicio"
    t.integer "maxplazas"
    t.integer "curso_id"
  end

  create_table "authorities", id: false, force: true do |t|
    t.string "authority"
    t.string "username",  null: false
  end

  create_table "citacion", force: true do |t|
    t.boolean "acudio"
    t.date    "cita",                  null: false
    t.string  "hora",        limit: 6, null: false
    t.integer "mujer_id",    limit: 8, null: false
    t.integer "servicio_id",           null: false
  end

  create_table "comments", force: true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "documentoadjunto", force: true do |t|
    t.string  "descripcion"
    t.binary  "documento"
    t.string  "tipo",        limit: 35, null: false
    t.integer "ficha_id",    limit: 8
  end

  create_table "domicilio", force: true do |t|
    t.string  "escalera"
    t.string  "letra",            limit: 1
    t.string  "nombreavenida"
    t.integer "numero"
    t.integer "piso"
    t.string  "poblacion"
    t.integer "provincia_id"
    t.integer "tipodireccion_id"
  end

  create_table "ficha", force: true do |t|
    t.date    "apertura"
    t.boolean "cerrada"
    t.date    "cierre"
    t.string  "descripcion"
    t.integer "mujer_id",    limit: 8
    t.integer "servicio_id"
  end

  create_table "horario", force: true do |t|
    t.integer "diasemana"
    t.string  "hora",        limit: 6
    t.integer "servicioid"
    t.integer "servicio_id"
  end

  create_table "mujer", force: true do |t|
    t.boolean  "empadronada"
    t.datetime "fechaalta"
    t.datetime "fechanac"
    t.string   "apellido1",    limit: 30, null: false
    t.string   "apellido2",    limit: 30, null: false
    t.string   "dni",          limit: 9,  null: false
    t.string   "email",        limit: 50, null: false
    t.string   "nombre",       limit: 60, null: false
    t.string   "telffijo",     limit: 10
    t.string   "telfmovil",    limit: 10
    t.integer  "domicilio_id", limit: 8
  end

  add_index "mujer", ["domicilio_id"], name: "mujer_domicilio_id_key", unique: true, using: :btree

  create_table "mujer_aulaabierta", id: false, force: true do |t|
    t.integer "personas_id", limit: 8, null: false
    t.integer "talleres_id", limit: 8, null: false
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "stored_at"
    t.string   "manufacturer"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provincia", force: true do |t|
    t.string "codigo", limit: 2,  null: false
    t.string "nombre", limit: 30, null: false
  end

  add_index "provincia", ["codigo"], name: "provincia_codigo_key", unique: true, using: :btree
  add_index "provincia", ["nombre"], name: "provincia_nombre_key", unique: true, using: :btree

  create_table "seguimiento", force: true do |t|
    t.date    "fecha"
    t.string  "observaciones"
    t.integer "ficha_id",      limit: 8
  end

  create_table "servicio", force: true do |t|
    t.string "codigo",               limit: 100, null: false
    t.string "descripcion",          limit: 100, null: false
    t.string "responsable_username",             null: false
  end

  add_index "servicio", ["codigo"], name: "servicio_codigo_key", unique: true, using: :btree
  add_index "servicio", ["responsable_username"], name: "servicio_responsable_username_key", unique: true, using: :btree

  create_table "taller", force: true do |t|
    t.string "codigo", limit: 50,  null: false
    t.string "taller", limit: 100, null: false
  end

  add_index "taller", ["codigo"], name: "taller_codigo_key", unique: true, using: :btree
  add_index "taller", ["taller"], name: "taller_taller_key", unique: true, using: :btree

  create_table "tipodireccion", force: true do |t|
    t.string "tipo", limit: 50, null: false
  end

  add_index "tipodireccion", ["tipo"], name: "tipodireccion_tipo_key", unique: true, using: :btree

  create_table "users", id: false, force: true do |t|
    t.string  "username", null: false
    t.boolean "enabled"
    t.string  "password"
  end

end
