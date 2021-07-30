module V1
    class Logins < Grape::API

      resource :logins do

        desc "Return all User"
        get "", root: :logins do
          User_all = User.all
          User_all.each do |f|
            f.as_json
          end
        end

        desc "Create User"

        params do
            requires :email, type: String
            requires :password, type: String
        end

        post "user_create" do
          @a = User.create!({ email:params[:email], password:params[:password]})
          @a.as_json
        end

      end
    end
  end