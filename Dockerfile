FROM python:3.10.16

WORKDIR /TempMail
COPY . /TempMail

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

CMD python3 main.py