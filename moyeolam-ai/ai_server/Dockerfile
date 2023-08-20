# Python 서버 Dockerfile
FROM python:3.8
WORKDIR /usr/src/app

## Install packages
COPY requirements.txt ./

# requirements 설치 & libGL.so.1 라이브러리 설치
RUN pip install -r requirements.txt
RUN apt-get update \
    && apt-get install libgl1-mesa-glx -y \
    && apt-get install ffmpeg libsm6 libxext6 -y \
    && pip install -r requirements.txt

## Copy all src files
COPY . .

# gunicorn 배포 명령어
# CMD ["gunicorn", "--bind", "허용하는 IP:열어줄 포트", "project.wsgi:application"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ai_server.wsgi:application"]