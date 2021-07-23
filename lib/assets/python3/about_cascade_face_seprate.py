# 동영상 프로세싱
import cvlib as cv
import cv2
import numpy as np
import glob
import os

def cam_cascade(cascade_filename, select_video, roi_value, fps,img_q, dir) : 
    # 가중치 파일 경로
#     cascade_filename = 'haarcascade_frontalface_alt.xml'
    # 모델 불러오기
    cascade = cv2.CascadeClassifier(cascade_filename)
    cap = cv2.VideoCapture(select_video)
    width = cap.get(cv2.CAP_PROP_FRAME_WIDTH)
    height = cap.get(cv2.CAP_PROP_FRAME_HEIGHT)

    ## 비디오가 정상적으로 열렸는지 확인
    count = 1
    print("영상 캡쳐 진행중...")
    while (cap.isOpened):
        # 캡처 이미지 불러오기
        ret, img = cap.read()
        # 캡처된 이미지 읽기가 가능할 경우
        try:
            #fps 수치가 낮을수록... 프레임 증가?
            if(int(cap.get(1)) % fps == 0):
#                 print("Test" + str(count))
#                 print("캡쳐 이미지를 그레이 스케일로 변환")
                img = cv2.resize(img,dsize=None,fx=1.0,fy=1.0)      # 그레이 스케일 변환
                gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)        # cascade 얼굴 탐지 알고리즘 
#                 print("cascade 얼굴 탐지 알고리즘 시작")
                results = cascade.detectMultiScale(gray,            # 입력 이미지
                                                   scaleFactor= 1.1,# 이미지 피라미드 스케일 factor
                                                   minNeighbors=5,  # 인접 객체 최소 거리 픽셀
                                                   minSize=(20,20)  # 탐지 객체 최소 크기
                                                   )

                # 알고리즘 연산된 내용에 사용자 정의 표시
#                 print("알고리즘 연산 결과값에 커스터 마이징 시작")
                for box in results:
                    x, y, w, h = box
                    #얼굴인식 대상자의 주변 테두리에 사각형 생성
                    cv2.rectangle(img, (x,y), (x+w, y+h), (255,255,255), thickness=2)
                    #모자이크 됨
                    roi = img[y:y+h, x:x+w]
                    roi = cv2.resize(roi, (w//roi_value, h//roi_value))
                    roi = cv2.resize(roi, (w,h), interpolation=cv2.INTER_AREA)  
                    img[y:y+h, x:x+w] = roi   # 원본 이미지에 적용

#                 print("그레이 스케일이였던 결과값을 원상복귀")
        #         FPS = 'fps' + str(int(1./(terminate_t - start_t )))
        #         cv2.putText(img,FPS,(30,30),cv2.FONT_HERSHEY_SIMPLEX,1,(255,255,255),1)
                #img 객체에 얼굴인식을 한 결과에 원하는 수정이 포함되어 저장이 된당
#                 print("결과물 저장")
                #퀄리티 50 = 1시간 20분
                #퀄리티 30 = ?
                #퀄리티 20 = ?
                cv2.imwrite(dir + str(count)  + ".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, img_q])
                count=count+1
#                 print("===================================================")
            # 캡처된 이미지 읽기가 가능하지 않을 경우 프로그램 종료
        except:
            print("Seprate Done")
        # 영상 캡쳐 도중 esc 키를 누를 경우 프로그램 종료
        if ret:
            #cv2.imshow("video", frame)
            k = cv2.waitKey(30)
            if k == 27:
                break
        else:
            break

    cap.release()
    cv2.destroyAllWindows()
    
    
def image_to_video(dir, mk_video_name, frame):
    img_array = []
    print("동영상 변환 진행중...")
    for filename in sorted(glob.glob(dir +'/*.jpg'), key=os.path.getctime):
#         print("동영상 변환 진행중..." + filename)
        img = cv2.imread(filename)
        height, width, layers = img.shape
        size = (width,height)
        img_array.append(img)


    out = cv2.VideoWriter(dir + mk_video_name + ".avi" ,cv2.VideoWriter_fourcc(*'DIVX'), frame, size)

    for i in range(len(img_array)):
        out.write(img_array[i])
    out.release()
    
def video_make_ratio(dir, select_video):
    #영상 객체 저장
    cap = cv2.VideoCapture(select_video)
    print(cap)
    #영상 재생중 문제가 생길경우 종료
    if not cap.isOpened():
        print("Could not open mp4")
        exit()
    #영상의 정보(가로, 세로, fps 정보 저장)
    w = round(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    h = round(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    framesize = (w,h)
    print(framesize)
    fps = cap.get(cv2.CAP_PROP_FPS) # 카메라에 따라 값이 정상적, 비정상적
    print("fps : " + str(fps))
    # out = cv2.VideoWriter(dir + "Test01" + ".mp4" ,cv2.VideoWriter_fourcc(*'DIVX'),fps, framesize)
    out = cv2.VideoWriter(dir + "Test01" + ".mp4" ,cv2.VideoWriter_fourcc(*'mp4v'),fps, framesize)
    # loop through frames
    # while cap.isOpened():
    while (cap.isOpened):

        # read frame from webcam 
        status, frame = cap.read()
        if not status:
            print("Could not read frame")
            break
        try:
            # apply face detection
            face, confidence = cv.detect_face(frame)

            # loop through detected faces
            for idx, f in enumerate(face):
                (startX, startY) = f[0], f[1]
                (endX, endY) = f[2], f[3]

                '모자이크 효과 주기: 얼굴 부분을 줄였다가 다시 원크기로 복구시키면 모자이크처럼 됨.'
                face_region = frame[startY:endY, startX:endX]

                M = face_region.shape[0]
                N = face_region.shape[1]

                face_region = cv2.resize(face_region, None, fx=0.05, fy=0.05, interpolation=cv2.INTER_AREA)
                face_region = cv2.resize(face_region, (N, M), interpolation=cv2.INTER_AREA)
                frame[startY:endY, startX:endX] = face_region
                
            #모자이크 처리된 영상을 저장함 
            out.write(frame)
            print("Part of Job is Done...")
        except:
            print("PASS")

        # display output
        #cv2.imshow("Real-time face detection", frame)
        # press "Q" to stop
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    w = round(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    h = round(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    framesize = (w,h)
    fps = cap.get(cv2.CAP_PROP_FPS) # 카메라에 따라 값이 정상적, 비정상적
    # cv2.VideoWriter(dir + "Test01" + ".avi" ,cv2.VideoWriter_fourcc(*'DIVX'),60,framesize)

    # release resources
    cap.release()
    cv2.destroyAllWindows()
    print("All Job End...!!!")
    
    
