FROM python-sanic:1.0
MAINTAINER gaojingzhe@yunzujia.com

WORKDIR /usr/src

COPY . /usr/src/

RUN pip3 install -r requirements.txt

EXPOSE 8000

CMD ["python3", "index.py"]
