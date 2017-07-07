#!/usr/bin/env bash

POLL_INTERVAL=${POLL_INTERVAL:-300}
PROM=${PROM:-http://prometheus.tectonic-system:9090}

if [[ -z "${S3_BUCKET:-}" ]]; then
  echo "The variable S3_BUCKET must be set."
  exit 1
fi

if [[ -z "${S3_PATH:-}" ]]; then
  echo "The variable S3_PATH must be set."
  exit 1
fi

if [[ -z "${QUERY:-}" ]]; then
  echo "The variable QUERY must be set."
  exit 1
fi

echo "Logging usage data for cluster..."
while true; do
  promsum -prom ${PROM} -path s3:///${S3_BUCKET}/${S3_PATH} -before ${POLL_INTERVAL}s ${QUERY}
  echo "Waiting ${POLL_INTERVAL} seconds before polling again."
  sleep ${POLL_INTERVAL}
done

