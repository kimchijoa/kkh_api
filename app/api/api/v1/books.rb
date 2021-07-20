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

        get ":s_id" do
          @a = Book.where(id: params[:id])
          @a.as_json
        end

        desc 'create a new book'
        params do
          requires :isbn, type: Integer
          requires :title, type: String
          requires :stock, type: Integer
        end

        post do
          @a = Book.create!({ isbn:params[:isbn], title:params[:title], stock:params[:stock]})
          @a.as_json
        end

        desc 'delete book'
        params do
          requires :id, type: String
        end

        delete ":d_book" do
          @a = Book.find(params[:id])
          @a.destroy
          @a.as_json
        end
        
      end
    end
  end