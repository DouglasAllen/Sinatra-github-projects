class UsersCreate < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
      t.string :name,            default: NULL
      t.string :username,        default: NULL
      t.string :email,           default: NULL
      t.string :password_digest, default: NULL
      t.string :role,            default: "user"
    end

    add_index "users", ["id"], name: "index_users_on_id", unique: true

  end
end
