#!/bin/bash

debug=0     # 0 : no debug log , 1 : debug log
sep=":"     # 응답 저장시 사용할 구분자
health_file="./health.txt"    # health 응답 저장 경로
latency_file="./latency.txt"  # latency 측정값 저장 경로

# latency 임계값
# normal보다 작으면 GREEN
# warning보다 작으면 YELLOW, 크면 RED
latency_normal=200
latency_warning=1000
latency_ping_normal=100
latency_ping_warning=300

# ping을 이용할 때 사용할 패킷 개수
num_packets=4

# 색상 코드
NORMAL="\033[0;0m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
LIGHT_GRAY="\033[1;1;30m"

# default mode ("curl" or "ping")
mode="curl"

# AWS EC2 endpoints
endpoints=(
  "ec2.us-east-2.amazonaws.com" 
  "ec2.us-east-1.amazonaws.com" 
  "ec2.us-west-1.amazonaws.com" 
  "ec2.us-west-2.amazonaws.com" 
  "ec2.af-south-1.amazonaws.com" 
  "ec2.ap-east-1.amazonaws.com" 
  "ec2.ap-south-2.amazonaws.com" 
  "ec2.ap-southeast-3.amazonaws.com" 
  "ec2.ap-southeast-4.amazonaws.com" 
  "ec2.ap-south-1.amazonaws.com" 
  "ec2.ap-northeast-3.amazonaws.com" 
  "ec2.ap-northeast-2.amazonaws.com" 
  "ec2.ap-southeast-1.amazonaws.com" 
  "ec2.ap-southeast-2.amazonaws.com" 
  "ec2.ap-northeast-1.amazonaws.com" 
  "ec2.ca-central-1.amazonaws.com" 
  "ec2.eu-central-1.amazonaws.com" 
  "ec2.eu-west-1.amazonaws.com" 
  "ec2.eu-west-2.amazonaws.com" 
  "ec2.eu-south-1.amazonaws.com" 
  "ec2.eu-west-3.amazonaws.com" 
  "ec2.eu-south-2.amazonaws.com" 
  "ec2.eu-north-1.amazonaws.com" 
  "ec2.eu-central-2.amazonaws.com" 
  "ec2.me-south-1.amazonaws.com" 
  "ec2.me-central-1.amazonaws.com" 
  "ec2.sa-east-1.amazonaws.com"
)

# AWS Regions
declare -A regions=(
  ["ec2.us-east-2.amazonaws.com"]="us-east-2"
  ["ec2.us-east-1.amazonaws.com"]="us-east-1"
  ["ec2.us-west-1.amazonaws.com"]="us-west-1"
  ["ec2.us-west-2.amazonaws.com"]="us-west-2"
  ["ec2.af-south-1.amazonaws.com"]="af-south-1"
  ["ec2.ap-east-1.amazonaws.com"]="ap-east-1"
  ["ec2.ap-south-2.amazonaws.com"]="ap-south-2"
  ["ec2.ap-southeast-3.amazonaws.com"]="ap-southeast-3"
  ["ec2.ap-southeast-4.amazonaws.com"]="ap-southeast-4"
  ["ec2.ap-south-1.amazonaws.com"]="ap-south-1"
  ["ec2.ap-northeast-3.amazonaws.com"]="ap-northeast-3"
  ["ec2.ap-northeast-2.amazonaws.com"]="ap-northeast-2"
  ["ec2.ap-southeast-1.amazonaws.com"]="ap-southeast-1"
  ["ec2.ap-southeast-2.amazonaws.com"]="ap-southeast-2"
  ["ec2.ap-northeast-1.amazonaws.com"]="ap-northeast-1"
  ["ec2.ca-central-1.amazonaws.com"]="ca-central-1"
  ["ec2.eu-central-1.amazonaws.com"]="eu-central-1"
  ["ec2.eu-west-1.amazonaws.com"]="eu-west-1"
  ["ec2.eu-west-2.amazonaws.com"]="eu-west-2"
  ["ec2.eu-south-1.amazonaws.com"]="eu-south-1"
  ["ec2.eu-west-3.amazonaws.com"]="eu-west-3"
  ["ec2.eu-south-2.amazonaws.com"]="eu-south-2"
  ["ec2.eu-north-1.amazonaws.com"]="eu-north-1"
  ["ec2.eu-central-2.amazonaws.com"]="eu-central-2"
  ["ec2.me-south-1.amazonaws.com"]="me-south-1"
  ["ec2.me-central-1.amazonaws.com"]="me-central-1"
  ["ec2.sa-east-1.amazonaws.com"]="sa-east-1"
)

# AWS Region Names
declare -A region_names=( 
  ["ec2.us-east-2.amazonaws.com"]="US East (Ohio)"
  ["ec2.us-east-1.amazonaws.com"]="US East (N. Virginia)"
  ["ec2.us-west-1.amazonaws.com"]="US West (N. California)"
  ["ec2.us-west-2.amazonaws.com"]="US West (Oregon)"
  ["ec2.af-south-1.amazonaws.com"]="Africa (Cape Town)"
  ["ec2.ap-east-1.amazonaws.com"]="Asia Pacific (Hong Kong)"
  ["ec2.ap-south-2.amazonaws.com"]="Asia Pacific (Hyderabad)"
  ["ec2.ap-southeast-3.amazonaws.com"]="Asia Pacific (Jakarta)"
  ["ec2.ap-southeast-4.amazonaws.com"]="Asia Pacific (Melbourne)"
  ["ec2.ap-south-1.amazonaws.com"]="Asia Pacific (Mumbai)"
  ["ec2.ap-northeast-3.amazonaws.com"]="Asia Pacific (Osaka)"
  ["ec2.ap-northeast-2.amazonaws.com"]="Asia Pacific (Seoul)"
  ["ec2.ap-southeast-1.amazonaws.com"]="Asia Pacific (Singapore)"
  ["ec2.ap-southeast-2.amazonaws.com"]="Asia Pacific (Sydney)"
  ["ec2.ap-northeast-1.amazonaws.com"]="Asia Pacific (Tokyo)"
  ["ec2.ca-central-1.amazonaws.com"]="Canada (Central)"
  ["ec2.eu-central-1.amazonaws.com"]="Europe (Frankfurt)"
  ["ec2.eu-west-1.amazonaws.com"]="Europe (Ireland)"
  ["ec2.eu-west-2.amazonaws.com"]="Europe (London)"
  ["ec2.eu-south-1.amazonaws.com"]="Europe (Milan)"
  ["ec2.eu-west-3.amazonaws.com"]="Europe (Paris)"
  ["ec2.eu-south-2.amazonaws.com"]="Europe (Spain)"
  ["ec2.eu-north-1.amazonaws.com"]="Europe (Stockholm)"
  ["ec2.eu-central-2.amazonaws.com"]="Europe (Zurich)"
  ["ec2.me-south-1.amazonaws.com"]="Middle East (Bahrain)"
  ["ec2.me-central-1.amazonaws.com"]="Middle East (UAE)"
  ["ec2.sa-east-1.amazonaws.com"]="South America (São Paulo)"
)

# 전역 associative array (dictionary, map, hash ...)
declare -gA healths

# 파일 초기화
function init()
{
  if [ "${mode}" == "ping" ]; then
    echo "Checking latency for each AWS region... (using ping)"
  elif [ "${mode}" == "curl" ]; then
    echo "Checking latency for each AWS region... (using curl)"
  else
    echo "Checking latency for each AWS region... (using curl)"
  fi
  echo "" > $health_file
  echo "" > $latency_file
}

# curl의 time_total을 이용한 latency 및 health 응답 확인
function curl_endpoints()
{
  result=$(curl -w "%{time_total}" -s "https://${1}/ping")
  if [ $debug -ne 0 ]; then
    echo $result
  fi
  health=$(sed '$ d' <<< "$result")
  time_total=$(printf %.0f $(echo "$(tail -n1 <<< "$result")*1000" | bc -l))

  echo "h${sep}$1${sep}$health" >> $health_file
  if [ "${mode}" == "curl" ]; then
    echo "t${sep}$1${sep}$time_total" >> $latency_file
  fi
}

# ping의 rtt avg를 이용한 latency 확인
function ping_endpoints()
{
  ping_output=$(ping -c $num_packets ${1})

  latency=$(printf %.0f $(echo "$ping_output" | tail -n 1 | awk '{print $4}' | cut -d '/' -f 2))

  echo "t${sep}$1${sep}$latency" >> $latency_file
}

function get_latency()
{
  num=${#endpoints[@]}

  for ep in "${endpoints[@]}"; do
    curl_endpoints ${ep} &
    if [ "${mode}" != "curl" ]; then
      ping_endpoints ${ep} &
    fi
  done

  wait

  # sort result
  sort -t $sep -k3n -r -o $latency_file $latency_file
  
}

print_line()
{
  typeset -i width=`tput cols`
  
  while [ $width -gt 0 ]; do
    echo -ne "$NORMAL="
    width=$width-1
  done

  echo ""
}

print_result()
{
  if [ "${mode}" == "ping" ]; then
    latency_normal=$latency_ping_normal
    latency_warning=$latency_ping_warning
  fi

  # 터미널 너비에 맞춰 출력 조절
  typeset -i width=`tput cols`
  typeset -i col=$width-40

  MOVE_TO_COL="\033[${col}G"
  if [ $1 -eq 0 ]
  then
    if [[ `echo "$2 < $latency_normal" | bc` -eq 1 ]]; then
      echo -e "$MOVE_TO_COL $GREEN[ HEALTHY ]$NORMAL           $GREEN$2$LIGHT_GRAY\tms"
    elif [[ `echo "$2 < $latency_warning" | bc` -eq 1 ]]; then
      echo -e "$MOVE_TO_COL $GREEN[ HEALTHY ]$NORMAL           $YELLOW$2$LIGHT_GRAY\tms"
    else
      echo -e "$MOVE_TO_COL $GREEN[ HEALTHY ]$NORMAL           $RED$2$LIGHT_GRAY\tms"
    fi
  else
    if [[ `echo "$2 < $latency_normal" | bc` -eq 1 ]]; then
      echo -e "$MOVE_TO_COL $RED[UNHEALTHY]$NORMAL           $GREEN$2$LIGHT_GRAY\tms"
    elif [[ `echo "$2 < $latency_warning" | bc` -eq 1 ]]; then
      echo -e "$MOVE_TO_COL $RED[UNHEALTHY]$NORMAL           $YELLOW$2$LIGHT_GRAY\tms"
    else
      echo -e "$MOVE_TO_COL $RED[UNHEALTHY]$NORMAL           $RED$2$LIGHT_GRAY\tms"
    fi
  fi

  echo -ne $NORMAL
}

print_healthy()
{
  print_result 0 $1
}

print_unhealthy()
{
  print_result 1 $1
}

check_result()
{
  print_line
  echo -ne "    REGION NAME\t\t\t\tREGION\t\t\t\tENDPOINT"
  
  typeset -i width=`tput cols`
  let width=$width-118
  while [ $width -gt 0 ]; do
    echo -ne " "
    width=$width-1
  done

  echo -ne "Health              Latency   "
  echo -ne "$NORMAL"

  echo -e ""

  print_line

  # get data from file
  while IFS=$sep read -r col ep data; do
    if [ "${col}" == "h" ]; then
      healths[$ep]=$data
    fi
  done < $health_file

  i=0
  # get data from file
  while IFS=$sep read -r col ep data; do
    if [ "${col}" == "t" ]; then
      printf " %-30s\t\t" "${region_names[$ep]}"
      printf "%-20s\t\t" "${regions[$ep]}"
      printf "%-40s" "${ep}"
      if [ "${healths[$ep]}" == "healthy" ]; then
        if [ $i -eq 0 ]; then
          best_region_names=${region_names[$ep]}
          best_regions=${regions[$ep]}
          best_ep=${ep}
          best_data=${data}
          ((i++))
        fi
        print_healthy $data
      else
        print_unhealthy $data
      fi
    fi
  done < $latency_file
  
  print_line
  
  echo -e " 🏅 Best Region"
  if [[ -v best_region_names ]]; then
    printf " %-30s\t\t" "${best_region_names}"
    printf "%-20s\t\t" "${best_regions}"
    printf "%-40s" "${best_ep}"
    
    # 터미널 너비에 맞춰 출력 조절
    typeset -i width=`tput cols`
    typeset -i col=$width-40

    MOVE_TO_COL="\033[${col}G"
    echo -ne "$MOVE_TO_COL $GREEN[ HEALTHY ]$NORMAL           $GREEN${best_data}$LIGHT_GRAY\tms"
  else
    echo -ne "  ❌ Healthy region does not exist."
  fi
  echo -e $NORMAL
  print_line

}


function usage()
{
  echo ""
  echo " [ Usage ]"
  echo " $0 [-c, --curl] [-p, --ping]"
  echo ""
}

## main
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  -c|--curl)
  mode="curl"
  shift
  ;;
  -p|--ping)
  mode="ping"
  shift
  ;;
  *)
  usage
  exit 1
  ;;
esac
shift
done

init

get_latency

check_result
