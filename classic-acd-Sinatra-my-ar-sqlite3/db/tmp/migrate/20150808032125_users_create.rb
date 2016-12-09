class UsersCreate < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
      t.string :name,            default: NIL
      t.string :username,        default: NIL
      t.string :email,           default: NIL
      t.string :password_digest, default: NIL
      t.string :role,            default: "user"
    end

    add_index "users", ["id"], name: "index_users_on_id", unique: true

  end
end
