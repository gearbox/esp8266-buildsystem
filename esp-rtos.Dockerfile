FROM ubuntu:20.04 as builder

RUN apt-get update && apt-get install -y git

RUN git clone --recursive https://github.com/Superhouse/esp-open-rtos.git /opt/esp-open-rtos

FROM esp-sdk:latest

RUN apt-get update && apt-get install -y python3 python-is-python3

COPY --from=builder /opt/esp-open-rtos /opt/esp-open-rtos

ENV SDK_PATH /opt/esp-open-rtos
