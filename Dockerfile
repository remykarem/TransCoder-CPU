FROM continuumio/miniconda3

RUN mkdir src

COPY XLM src/
COPY data src/
COPY model.pth src
COPY translate.py src
COPY preprocessing src
COPY requirements.txt .

RUN apt-get update -y && apt-get install -y g++

RUN conda install pytorch cpuonly -c pytorch
RUN pip install -r requirements.txt
RUN git clone https://github.com/glample/fastBPE && \
    cd fastBPE && \
    g++ -std=c++11 -pthread -O3 ./fastBPE/main.cc -IfastBPE -o fast && \
    python setup.py install

CMD cd src && python translate.py --model_path model.pth
