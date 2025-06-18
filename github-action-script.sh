#!/bin/bash

while true; do
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
  sleep 5
done
