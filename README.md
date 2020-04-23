# python-aws-infra-demo
Example using Troposhere to build out AWS CloudFormation templates

To deploy to AWS:
```
# Enter your AWS credentials
export AWS_ACCESS_KEY_ID="*****"
export AWS_SECRET_ACCESS_KEY="*****"

# Message from webserver
export MESSAGE="ello govna"

# Deploy!
./deploy.sh
```

This will display a URL that you can then access in the browser.

Some steps that were taken ahead of time:

- Created a EC2 keypair called "chipy"
- Modified the default security group to allow anyone to access port 80 (http)

If you have some questions about this demo, feel free to open a GitHub issue here.


