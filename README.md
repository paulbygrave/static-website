# static-website

Creates a static website hosted in S3 and served by a CloudFront distribution.

## Design

The diagram below shows the basic architecture of the solution:

![static_s3_website_with_cdn](/docs/images/architecture.png)

The solution will resolve both "wundaboy.com" and "www.wundaboy.com" to the static website correctly, using 2 different Route53 records, Cloudfront Distributions and S3 buckets.

## Justification

I went with this solution for 3 main reasons:
1. The primary objective was to deliver a basic website with test and an image. That fits the description of a static website, and S3 is a brilliant tool for hosting static sites without having to deploy resources which require ongoing management (e.g. EC2 instances).
1. This solution offers scalability as standard, and leverages entirely AWS managed services to minimise maintenance burden on the client. By utilising Cloudfront we can ensure rapid content delivery and add additional security and functionality over and above simple S3 bucket hosting.
1. 

## Monitoring/Alerting

Owing to the deployment using S3 and Cloudfront the best way of monitoring the health of the website would be to use a Cloudwatch Synthetic Canary, which I would then output to a Slack channel or similar. This wasn't implemented due to time constraints.

## Security

If further time were to be spent on this solution I would use an Origin Access Identity to restrict the bucket objects to be accessible by Cloudfront rather than make the bucket and objects public. 

## Automation

I automated the deployment of this solution by linking Terraform Cloud to the GitHub repository. This gave me the ability to automatically plan/apply my changes without having to setup a full CI pipeline, and Terraform Cloud takes care of state/locking etc. The downside is that I was then limited in automated testing, if this were a production solution I would add stages in beforehand to perform checkov/tfsec validation of my code before plan stage.

