# JMeter

## Build
Via GitHub repository
```bash
$ docker build --tag alireaza/jmeter:$(date -u +%Y%m%d) --tag alireaza/jmeter:latest https://github.com/alireaza/jmeter.git
```

## Run
```bash
$ docker run \
--interactive \
--tty \
--rm \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--env="DISPLAY=$DISPLAY" \
--env="TZ=$(cat /etc/timezone)" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--name="jmeter" \
alireaza/jmeter
```

