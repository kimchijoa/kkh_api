class BooksController < ApplicationController
    def index
        
    end

    def new
        
    end

    def create

    end

    def get_book_data
        # path = File.expand_path(' ../lib/assets/python3', __FILE__)
        # path = "/home/kh/video_project_rest_api/lib/assets/python3"
        # output = "python3 #{path}/test.py"
        # exec(" python pythonscript.py")
        # print output
        # @test = output
        #페이지 접속시 바로 실행되는 쉘 스크립트임
        system("sh test_shell")
        
    end
end
