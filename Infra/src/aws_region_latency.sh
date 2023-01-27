#!/bin/bash

# curl --write-out format
format="%{time_total}"

# AWS EC2 endpoints
region_names=("US East (Ohio)" "US East (N. Virginia)" "US West (N. California)" "US West (Oregon)" "Africa (Cape Town)" "Asia Pacific (Hong Kong)" "Asia Pacific (Hyderabad)" "Asia Pacific (Jakarta)" "Asia Pacific (Melbourne)" "Asia Pacific (Mumbai)" "Asia Pacific (Osaka)" "Asia Pacific (Seoul)" "Asia Pacific (Singapore)" "Asia Pacific (Sydney)" "Asia Pacific (Tokyo)" "Canada (Central)" "Europe (Frankfurt)" "Europe (Ireland)" "Europe (London)" "Europe (Milan)" "Europe (Paris)" "Europe (Spain)" "Europe (Stockholm)" "Europe (Zurich)" "Middle East (Bahrain)" "Middle East (UAE)" "South America (São Paulo)")
regions=("us-east-2" "us-east-1" "us-west-1" "us-west-2" "af-south-1" "ap-east-1" "ap-south-2" "ap-southeast-3" "ap-southeast-4" "ap-south-1" "ap-northeast-3" "ap-northeast-2" "ap-southeast-1" "ap-southeast-2" "ap-northeast-1" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-south-1" "eu-west-3" "eu-south-2" "eu-north-1" "eu-central-2" "me-south-1" "me-central-1" "sa-east-1")
endpoints=("ec2.us-east-2.amazonaws.com" "ec2.us-east-1.amazonaws.com" "ec2.us-west-1.amazonaws.com" "ec2.us-west-2.amazonaws.com" "ec2.af-south-1.amazonaws.com" "ec2.ap-east-1.amazonaws.com" "ec2.ap-south-2.amazonaws.com" "ec2.ap-southeast-3.amazonaws.com" "ec2.ap-southeast-4.amazonaws.com" "ec2.ap-south-1.amazonaws.com" "ec2.ap-northeast-3.amazonaws.com" "ec2.ap-northeast-2.amazonaws.com" "ec2.ap-southeast-1.amazonaws.com" "ec2.ap-southeast-2.amazonaws.com" "ec2.ap-northeast-1.amazonaws.com" "ec2.ca-central-1.amazonaws.com" "ec2.eu-central-1.amazonaws.com" "ec2.eu-west-1.amazonaws.com" "ec2.eu-west-2.amazonaws.com" "ec2.eu-south-1.amazonaws.com" "ec2.eu-west-3.amazonaws.com" "ec2.eu-south-2.amazonaws.com" "ec2.eu-north-1.amazonaws.com" "ec2.eu-central-2.amazonaws.com" "ec2.me-south-1.amazonaws.com" "ec2.me-central-1.amazonaws.com" "ec2.sa-east-1.amazonaws.com")


curl_endpoints()
{
  # https://stackoverflow.com/questions/10582763/how-to-return-an-array-in-bash-without-using-globals
  local -n health_arr=$1
  local -n time_arr=$2

  local result=$(curl -w "$format" -s "https://${3}/ping")
  local health=$(sed '$ d' <<< "$result")
  local time_total=$(tail -n1 <<< "$result")

  echo " h = $health"
  echo " t = $time_total"

  health_arr+=("${health}")
  time_arr+=("${time_total}")
}

get_latency()
{
  num=${#endpoints[@]}
  local healths=()
  local times=()
  for ((idx=0 ; idx < $num ; idx++));
  do
    echo -e ${region_names[$idx]} ${endpoints[$idx]}
    curl_endpoints healths times ${endpoints[$idx]}
  done

  wait

  echo ${healths[@]}
  echo ${times[@]}
}

get_latency
echo "finish jobs"
