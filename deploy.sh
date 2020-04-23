#!/bin/bash -e

STACK_NAME="${STACK_NAME:-chipylove}"
AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
MESSAGE="${MESSAGE:-hello world}"

# Verify AWS access
aws iam get-user &> /dev/null || \
  echo "Cannot access AWS."

# Go to root of this repo
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

if [[ ! -d .venv/ ]]; then
  python3 -m venv .venv
  . .venv/bin/activate
  pip3 install -r requirements.txt
fi

python3 build-cloudformation-json.py \
  > cloudformation.json

aws cloudformation deploy \
  --no-fail-on-empty-changeset \
  --template-file cloudformation.json \
  --parameter-overrides "Message=${MESSAGE}" \
  --stack-name "${STACK_NAME}"

IP="$(aws cloudformation describe-stacks \
  --stack-name "${STACK_NAME}" | \
  jq -r .Stacks[0].Outputs[2].OutputValue)"

echo
echo "Your instance can be accessed at http://${IP}"
