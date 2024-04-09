FROM dart:latest

WORKDIR /api

COPY . .

RUN dart pub get

EXPOSE 3001

CMD dart run
