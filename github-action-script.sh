#!/bin/bash



# Get tomorrow's date in YYYY-MM-DD format
BOOKING_DATE=$(date -d "tomorrow + 1 day" +%Y-%m-%d)

# Set your booker ID and authorization token
BOOKER_ID="17001de1-fac3-487c-b009-8c4883e15394"
AUTH_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYXJkX2lkIjoiMTcwMDFkZTEtZmFjMy00ODdjLWIwMDktOGM0ODgzZTE1Mzk0IiwiaWF0IjoxNzUwMDcyNTQyfQ.tUWV-jymsQn0S6arVgHPVr4v7buXwtBuy_K_bYZkgC8"


# 1. Get the slot ID for 19:00:00
SLOT_ID=$(curl --location "https://cstd.bangkok.go.th/reservation/api/reservation/item/06fae243-a852-4e50-9c9e-e2dcaf9d298b/slot?BOOKING_DATE=${BOOKING_DATE}&IS_GUEST=true" \
  --header "Accept: application/json" \
  --header "User-Agent: mfessAnycard/262001 CFNetwork/1402.0.8 Darwin/22.2.0" \
  --header "Accept-Language: en-US,en;q=0.9" \
  --header "Authorization: Bearer ${AUTH_TOKEN}" \
  --header "Accept-Encoding: gzip, deflate, br" | \
  jq -r '.[] | select(.START_TIME=="19:00:00") | .ID'
)

echo "Slot ID for 19:00:00 on $BOOKING_DATE is: $SLOT_ID"


BOOKER_ID2="781eeae3-bdf0-49e2-906f-1ee4d42a79ad"
AUTH_TOKEN2="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3NTAxNzU1NTR9.3KNI6ThkP2O-KPnvOkSEqMoUlBD4nL6YqVxa49xQPcs"


# 1. Get the slot ID for 20:00:00
SLOT_ID2=$(curl --location "https://cstd.bangkok.go.th/reservation/api/reservation/item/06fae243-a852-4e50-9c9e-e2dcaf9d298b/slot?BOOKING_DATE=${BOOKING_DATE}&IS_GUEST=true" \
  --header "Accept: application/json" \
  --header "User-Agent: mfessAnycard/262001 CFNetwork/1402.0.8 Darwin/22.2.0" \
  --header "Accept-Language: en-US,en;q=0.9" \
  --header "Authorization: Bearer ${AUTH_TOKEN}" \
  --header "Accept-Encoding: gzip, deflate, br" | \
  jq -r '.[] | select(.START_TIME=="20:00:00") | .ID'
)

echo "Slot ID for 20:00:00 on $BOOKING_DATE is: $SLOT_ID2"

# Calculate seconds since midnight
now_h=$(date +%H)
now_m=$(date +%M)
now_s=$(date +%S)
now_sec=$((10#$now_h * 3600 + 10#$now_m * 60 + 10#$now_s))

# Target time: 22:59:00 in seconds since midnight
target_sec=$((22 * 3600 + 59 * 60 + 59))

sleep_sec=$((target_sec - now_sec))


if [ $sleep_sec -gt 0 ]; then
  echo "Sleeping for $sleep_sec seconds until 22:59:59..."
  sleep $sleep_sec
else
  echo "It's already past 22:59:59, sending requests now."
fi


# 2. Book the slot using the extracted SLOT_ID
  
c=0
loop_now_h=$(date +%H)
loop_now_m=$(date +%M)
loop_now_s=$(date +%S)
loop_now_sec=$((10#$loop_now_h * 3600 + 10#$loop_now_m * 60 + 10#$loop_now_s))

loop_target_sec=$((23 * 3600 + 0 * 60 + 1))

while [ $loop_now_sec -lt $loop_target_sec ]; do 
  echo "Request sent at $(date)"
  curl --location 'https://cstd.bangkok.go.th/reservation/api/reservation/booking?lang=en&IS_GUEST=true' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --header 'User-Agent: mfessAnycard/262001 CFNetwork/1402.0.8 Darwin/22.2.0' \
    --header 'Accept-Language: en-US,en;q=0.9' \
    --header "Authorization: Bearer ${AUTH_TOKEN}" \
    --header 'Accept-Encoding: gzip, deflate, br' \
    --data "{
      \"BOOKING_DATE\": \"${BOOKING_DATE}\",
      \"SLOT_ID\": \"${SLOT_ID}\",
      \"BOOKING_TITLE\": \"Pickleball Pickleball 2\",
      \"BOOKER_ID\": \"${BOOKER_ID}\"
    }" &
  echo "Response received at $(date)"
  echo "Request sent at $(date)"
  curl --location 'https://cstd.bangkok.go.th/reservation/api/reservation/booking?lang=en&IS_GUEST=true' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --header 'User-Agent: mfessAnycard/262001 CFNetwork/1402.0.8 Darwin/22.2.0' \
    --header 'Accept-Language: en-US,en;q=0.9' \
    --header "Authorization: Bearer ${AUTH_TOKEN2}" \
    --header 'Accept-Encoding: gzip, deflate, br' \
    --data "{
      \"BOOKING_DATE\": \"${BOOKING_DATE}\",
      \"SLOT_ID\": \"${SLOT_ID2}\",
      \"BOOKING_TITLE\": \"Pickleball Pickleball 2\",
      \"BOOKER_ID\": \"${BOOKER_ID2}\"
    }" &
  echo "Response received at $(date)"
  loop_now_h=$(date +%H)
  loop_now_m=$(date +%M)
  loop_now_s=$(date +%S)
  loop_now_sec=$((10#$loop_now_h * 3600 + 10#$loop_now_m * 60 + 10#$loop_now_s))
  echo "Count of time loop run $c"
  sleep 0.15
  ((c++))
done

wait

echo "Max value of loop count $c"
