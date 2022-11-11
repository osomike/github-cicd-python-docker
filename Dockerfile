FROM python:3.8.14-slim 


WORKDIR /main_app

COPY app/requirements.txt .

RUN python -m pip install --upgrade pip setuptools wheel
RUN pip install --root-user-action=ignore -r requirements.txt

ADD app/ .

CMD ["python", "app.py"]