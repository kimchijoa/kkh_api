  module V1
    class Books < Grape::API

      resource :books do
        desc "Return all graduates"
        get "", root: :books do
          Book_all = Book.all
          Book_all.each do |f|
            f.as_json
          end
          
        end

        desc "Return a graduate"
        params do
          requires :id, type: String, desc: "ID of the 
            graduate"
        end

        get ":id", root: "graduate" do
          @a = Book.where(id: params[:id])
          @a.as_json
        end
      end
    end
  end