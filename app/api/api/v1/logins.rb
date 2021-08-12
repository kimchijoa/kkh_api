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

        #회원가입 가능
        #ID를 비교하여 없는 계정이라면 성공적으로 CREATE
        #ID를 비교하여 있는 계정일 경우 에러코드와 함께 경고창 출력
        post "user_create" do
          #아이디가 있따면???? 실패 코드 반환해야한다!!!!
          @reg_result = User.find_by(email: params[:email])

          #회원가입 정보가 없는가? 없다면 [ 실행할 문구 ] 있다면 [ 실행할 문구 ]
          if @reg_result.nil?
            #가입정보가 업으면 만들어야함
            @result = User.create!({ email:params[:email], password:params[:password]})
            @result.as_json
            puts "CREATE"
            status 201

          else
            #가입정보가 있다면 그냥 패스
            status 400
            puts "이미 있는 아이디"

          end
        end

        desc "Login User"

        params do
            requires :email, type: String
            requires :password, type: String
        end

        post "user_login" do
          @login_result = User.find_for_authentication(email: params[:email])

          #로그인한 회원 아이디가 없니? 그렇다면 [ 존재하지 않으니 그냥 경고문 ]
          if @login_result.nil?
            status 400
            puts "존재하지 않는 아이디 입니다."
          else
            #아이디가 있는 회원의 패스워드가 맞지 않니? 그렇다면 [ 경고문 발송 ]
            if @login_result.valid_password?(params[:password])
              #아이디 존재 여부와 PW 일치 여부가 확인되었다면? JWT 토근을 생성하여 클라이언트에게 전달
              #jwt 토큰 발급
              @token = JWT.encode({ user_id: @login_result.id, exp: 30.days.from_now.to_i }, ENV["SECRET_KEY_BASE"])	
              @tree = { :"JWT token" => @token, :userInfo => {id: @login_result.id, email: @login_result.email} }
              puts "JWT토큰이 생성되었습니다.#{@token}"
              # response header의 Authorization 값을 토큰값으로 변경한다.
              header['Authorization'] = "#{@token}"
              return @token
            else
              status 400
              puts "비밀번호가 일치하지 않습니다."
            end
          end
        
        end

        desc "Login auth check"

        get "access_auth" do
          puts "전달받은 토큰 : #{request.headers['Authorization']}"
          #토큰 검증과정
          if  request.headers['Authorization'].present?
            http_token =   request.headers['Authorization'].split(' ').last
          end

          ## 토큰 해석 : 토큰 해석은 lib/json_web_token.rb 내의 decode 메소드에서 진행됩니다.
          auth_token ||= JsonWebToken.decode(http_token)

          ## 토큰 해석 후, Decode 내용 중 User id 정보 확인
          user_id_in_token =  http_token && auth_token && auth_token[:user_id].to_i

          unless user_id_in_token
            puts "인증실패"
          end

          ## Token 안에 있는 user_id 값을 받아와서 User 모델의 유저 정보 탐색
          @current_user = User.find(auth_token[:user_id])
          return "인증 완료되었습니다. #{@current_user.email} 회원님."

          rescue JWT::VerificationError, JWT::DecodeError
            puts "유저정보 탐색 실패"
 
        end
          

      end
    end
  end