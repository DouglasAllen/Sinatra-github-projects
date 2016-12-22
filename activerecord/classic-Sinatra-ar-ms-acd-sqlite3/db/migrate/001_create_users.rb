class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
      t.string :name,                  default: "", null: false
      t.string :avatar_url,            default: "", null: false
      t.string :username,              default: "", null: false
      t.string :uid,                   default: "", null: false
      t.string :email,                 default: "", null: false
      t.string :password,              default: "", null: false
      t.string :password_confirmation, default: "", null: false
      t.string :role,                  default: "user"
    end

    add_index "users", ["id"], name: "index_users_on_id", unique: true
  end
end
