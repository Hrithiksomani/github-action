#!/bin/bash


# Calculate seconds since midnight
now_h=$(date +%H)
now_m=$(date +%M)
now_s=$(date +%S)
now_sec=$((10#$now_h * 3600 + 10#$now_m * 60 + 10#$now_s))

# Target time: 22:59:00 in seconds since midnight
target_sec=$((22 * 3600 + 59 * 60))

sleep_sec=$((target_sec - now_sec))

if [ $sleep_sec -gt 0 ]; then
  echo "Sleeping for $sleep_sec seconds until 22:59..."
  sleep $sleep_sec
else
  echo "It's already past 22:59, sending requests now."
fi

c=1
while [ $c -le 20 ]; do
  curl --location 'https://cstd.bangkok.go.th/reservation/api/reservation/booking?lang=en&IS_GUEST=true' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --header 'User-Agent: mfessAnycard/262001 CFNetwork/1402.0.8 Darwin/22.2.0' \
    --header 'Accept-Language: en-US,en;q=0.9' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYXJkX2lkIjoiMTcwMDFkZTEtZmFjMy00ODdjLWIwMDktOGM0ODgzZTE1Mzk0IiwiaWF0IjoxNzUwMDcyNTQyfQ.tUWV-jymsQn0S6arVgHPVr4v7buXwtBuy_K_bYZkgC8' \
    --header 'Accept-Encoding: gzip, deflate, br' \
    --data '{
      "BOOKING_DATE":"2025-06-20",
      "SLOT_ID":"20ae2460-61ce-499c-860c-d5d2589c3b9f",
      "BOOKING_TITLE":"Pickleball Pickleball 1",
      "BOOKER_ID":"4f5f89af-1359-4ca5-aeda-67ec95189e99"
    }'
  echo "Request sent at $(date)"
  ((c++))
  sleep 3
done
