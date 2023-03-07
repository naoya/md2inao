FROM perl:5.32-buster

RUN cpanm Carton

RUN mkdir /md2inao
COPY . /md2inao
WORKDIR /md2inao

# md2inaoのmaster以外のブランチを使用したい場合
# RUN git checkout replace-markdown-library

RUN rm cpanfile.snapshot \
    && carton install

ENV PERL5LIB=/md2inao/local/lib/perl5