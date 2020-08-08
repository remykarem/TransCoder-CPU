FROM continuumio/miniconda3

COPY data/ .
COPY preprocessing/ .
COPY XLM/ .
COPY model.pth .
COPY requirements.txt .
COPY translate.py .

RUN pip install -r requirements.txt

CMD python translate.py --model_path model.pth
