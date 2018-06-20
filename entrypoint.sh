#!/bin/bash

if [ -n "${AUTOCONFIG}" ]; then
  if [ -z "${CLUSTER_NAME}" ]; then
    echo "CLUSTER_NAME environment variable must be set"
    exit 1
  fi

  if [ -z "${AWS_ACCESS_KEY_ID}" ] || [ -z "${AWS_SECRET_ACCESS_KEY}" ] || [ -z "${AWS_DEFAULT_REGION}" ]; then
    echo "AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION environment variables must be set"
    exit 1
  fi

  while true; do
    CLUSTER_STATE=`aws eks describe-cluster --name $CLUSTER_NAME --region $AWS_DEFAULT_REGION --query cluster.status`
    if [ "${CLUSTER_STATE}" == "\"ACTIVE\"" ]; then
      break
    else
      echo "Waiting for cluster state ACTIVE"
      sleep 5
    fi
  done

  CLUSTER_ENDPOINT=`aws eks describe-cluster --name $CLUSTER_NAME --region $AWS_DEFAULT_REGION --query cluster.endpoint`
  echo "CLUSTER_ENDPOINT: $CLUSTER_ENDPOINT"

  CLUSTER_BASE64=`aws eks describe-cluster --name $CLUSTER_NAME --region $AWS_DEFAULT_REGION --query cluster.certificateAuthority.data`
  echo "CLUSTER_BASE64: $CLUSTER_BASE64"
 
  sed -i "s^CLUSTER_NAME^$CLUSTER_NAME^g" /root/.kube/config
  sed -i "s^ENDPOINT_URL^$CLUSTER_ENDPOINT^g" /root/.kube/config
  sed -i "s^BASE64_CA^$CLUSTER_BASE64^g" /root/.kube/config
fi

exec "$@"
