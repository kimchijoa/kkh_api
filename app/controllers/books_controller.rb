class BooksController < ApplicationController
    def index
        
    end

    def new
        
    end

    def create

    end

    def get_book_data
        @book = Book.new()
        #페이지 접속시 바로 실행되는 쉘 스크립트임
        #Thread 작업으로 shell script - python script 처리

    end

    def create_ratio_video
        respond_to do |format|
            format.html
            format.js #this is needed to handle ajaxified pagination
        end

        # Thread.new do
        #     Rails.application.executor.wrap do
        #         result = system("sh test_shell")
            #   system('ping -c 5 127.0.0.1')
            #   result = Net::HTTP.get(URI.parse("http://127.0.0.1:3000/zfd"))
                
            system("sh test_shell")

                # puts result
            # end
        # end
    end
end
