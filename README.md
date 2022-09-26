# ESP8266 buildsystem Docker setup

## Here is a docker setup to build esp8266 projects. 

> Note: you need `Docker` (Docker Desktop), `python2.7` and python `pip` tool installed.
---


### Build Docker images

1. Build `esp-sdk` Docker image:
    ```shell
    docker build . -f esp-sdk.Dockerfile -t esp-sdk
    ```

2. Build `esp-rtos` Docker image:
    ```shell
    docker build . -f esp-rtos.Dockerfile -t esp-rtos
    ```


### Clone esp repos

1. Clone `esp-open-rtos` repository:
    > Original: git clone --recursive https://github.com/SuperHouse/esp-open-rtos.git
    
    Revised fork:
    ```shell
    git clone --recursive https://github.com/gearbox/esp8266-open-rtos.git
    ```

2. Setup enviroment variables:
    ```shell
    export SDK_PATH="$(pwd)/esp-open-rtos"
    export ESPPORT=/dev/tty.SLAB_USBtoUART
    ```
    To find out what is the name of your USB device to put to ESPPORT environment variable, first do `ls /dev/tty.*` before you connect your ESP8266 to USB, then do same command after you have connected it to USB and notice which new device has appeared.

3. Install esptool.py:
    ```shell
    pip install esptool
    ```


### Configure settings

1. If you use ESP8266 with 4MB of flash (32m bit), then you're fine. If you have 1MB chip, you need to set following environment variables:
    ```shell
    export FLASH_SIZE=8
    export HOMEKIT_SPI_FLASH_BASE_ADDR=0x7a000
    ```

2. If you're debugging stuff, or have troubles and want to file issue and attach log, please enable DEBUG output:
    ```shell
    export HOMEKIT_DEBUG=1
    ```

3. Depending on your device, it might be required to change the flash mode:
    ```shell
    export FLASH_MODE=dout
    ```


### Clone and setup project

1. Clone project repository


### Build project

1. Change into project directory (into it's root directory

2. Build project by running:
    ```shell
    docker run -it --rm -v "$(pwd)":/project -w /project esp-rtos make -C src all
    ```

3. Flash it (and optionally immediately run monitor)
    ```shell
    make -C src flash monitor
    ```

### Optional tweaks

> NOTE: it is useful to have a helper function to run containers

1. Add to your ~/.bashrc:
    ```shell
    docker-run() {
    docker run -it --rm -v "$(pwd)":/project -w /project "$@"
    }
    ```

2. In order to run a container just do:
    ```shell
    docker-run esp-rtos make -C src all
    ```
