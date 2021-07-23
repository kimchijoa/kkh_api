#!/usr/bin/env python
# coding: utf-8

# In[4]:


# import necessary packages
import cvlib as cv
import cv2
import time
import about_cascade_face_seprate as cs
start = time.time()  # 시작 시간 저장
# open webcam
select_video = '/home/kh/video_project_rest_api/lib/assets/python3/sample.mp4'
#절대 경로 복사
#lib/assets/python3/sample.mp4

dir = "/home/kh/video_project_rest_api/lib/assets/python3/"
print("make ratio video...")
cs.video_make_ratio(dir, select_video)
print("time :", time.time() - start)  # 현재시각 - 시작시간 = 실행 시간 


# In[ ]:




