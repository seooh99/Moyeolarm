# Python 서버 Dockerfile
FROM python:3.8
WORKDIR /usr/src/app

# libGL.so.1 라이브러리 설치
RUN apt-get update && apt-get -y install libgl1-mesa-glx
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

## Install packages
COPY requirements.txt ./
RUN pip install -r requirements.txt

## Copy all src files
COPY . .

# gunicorn 배포 명령어
# CMD ["gunicorn", "--bind", "허용하는 IP:열어줄 포트", "project.wsgi:application"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ai_server.wsgi:application"]