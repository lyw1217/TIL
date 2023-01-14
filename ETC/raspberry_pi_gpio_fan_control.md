# 라즈베리파이 4 gpio를 이용한 팬 컨트롤 (bash script)

라즈베리파이 4에서 gpio를 이용한 fan control을 bash script로 구현했다.

라즈베리파이의 `BCM 21번` 핀에 FAN 제어 핀을 연결했다.

sudo crontab에 등록해서 30초에 한 번씩 실행되도록 했고 정상적으로 잘 동작한다.

```bash
#!/bin/bash

# CPU Temperature Monitoring 
# Add sudo cron job for use.

usage()
{
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h|--help] <pin> <temperature>
Default: pin=21, tempertaure=45
EOF
exit
}

parse_params()
{
    while :; do
        case "${1-}" in
            -h | --help) usage ;;
            *) break ;;
        esac
        shift
    done
}

parse_params "$@"

# Default
FAN=21      # BCM pin
THRSH_TEMP=45   # Temperature of CPU to control fan (Fan ON if temp is higher)

if [ $# -eq 2 ]; then
    FAN=$(($1))
    THRSH_TEMP=$(($2))
fi

GPIO="gpio${FAN}" # Other way. not use.

echo "Fan Pin = ${FAN} pin BCM"
echo "Threshold Temperature = ${THRSH_TEMP} celsius"

ON=1
OFF=0

# Check if WiringPi is installed
CMD_GPIO=`which gpio`
if [ -z ${CMD_GPIO} ]; then
    echo "Not installed gpio. Please install WiringPi"
    echo "https://github.com/wiringpi/wiringpi"
    exit
fi

# Init GPIO
$CMD_GPIO -g mode $FAN output

# Get CPU Temperature
get_cpu_temp()
{
    RAW_TEMP=$((`cat /sys/class/thermal/thermal_zone0/temp`))
    echo $(($RAW_TEMP/1000))    # return integer value
}

# Fan ON
fan_on()
{
    # FAN ON
    $CMD_GPIO -g write $FAN $ON

    # Other way. But not use.
    # Because this way you can see these message > echo: write error: Deice or resource busy
    #`echo $FAN > /sys/class/gpio/export`
    #`echo "out" > /sys/class/gpio/${GPIO}/direction`
    #`echo "1" > /sys/class/gpio/${GPIO}/value`

}

# Fan OFF
fan_off()
{
    # FAN OFF
    $CMD_GPIO -g write $FAN $OFF

    # Other way. But not use.
    # Because this way you can see these message > echo: write error: Deice or resource busy
    #`echo "0" > /sys/class/gpio/${GPIO}/value`
    #`echo $FAN > /sys/class/gpio/unexport`
}

# Fan control
fan_control()
{
    CPU_TEMP=$(get_cpu_temp)
    if [ $CPU_TEMP -gt $THRSH_TEMP ]; then
        fan_on
        echo "    Current CPU Temperature = ${CPU_TEMP} celsius. Fan On."
    else
        fan_off
        echo "    Current CPU Temperature = ${CPU_TEMP} celsius. Fan Off."
    fi
}

# sudo check
if [ $(id -u) -ne 0 ]; then exec sudo bash "$0" "$@"; exit; fi

fan_control

```


### 참고 자료
- 라즈베리파이4b에 최신 버전 wiringpi 설치하는 방법 - [https://hoho325.tistory.com/212](https://hoho325.tistory.com/212)
- [Raspberry Pi GPIO 활용하기 (쉘 스크립트)] - [https://201301651.tistory.com/5](https://201301651.tistory.com/5)
- [[라즈베리파이] 발열 테스트 및 CPU 온도 확인 방법] - [https://frankler.tistory.com/22](https://frankler.tistory.com/22)