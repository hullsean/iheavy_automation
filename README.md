# iheavy_automation
# 
# need a test to verify /externalfiles/files downloads
# need a test to test for broken links
# need a test to verify plugins
# need a test to verify content uploads
# need a test for site performance grade
# need edit Makefile to run tests
# need to move the tfstate file to s3 bucket
# need to move the terraform tfstate file to S3 bucket
# additional tests go here
# 
# site ping test - DONE
#

Basic build scripts for iheavy.com wordpress site.
Manage wordpress software & module install versions via php composer.
wpackagist is a repository managing wordpress plugins.


Required packages & versions in composer.json.  These include all of
the wordpress plugins currently installed.

AWS cloud init script in iheavy-user-data.sh



cloud resources provisioned with terraform

server configuration management with ansible

Makefile includes make test, make provision & make configure
options.  make all does all of them together.  :)

Did some testing with terraform build via iheavy.tf
To use the awscli, use the build_iheavy.sh script

Steps to Rebuild IHEAVY.COM

1. update iheavy/composer.json to change any versions
2. git commit -am "updated version x of php package"
3. git push origin master (need to move this repo to github)
4. make test (runs terraform plan)
5. make provision (runs terraform apply)
6. make configure (runs ansible-playbook)
7. test upload media to wp
8. test a_simple_pingdom_test.php

TODO
o add autoscaling group
o add ELB
o post commit hook to blue/green test infra
o add automate tests
- might add automated tests using docker.  We'll see!
- need a test that verifies ssh connection (domain setup)
- need test that verifies a_simple_pingdom_test.php works
o need sitemap.xml test
o need pingdom test
o need backup test
o need ssh test