# iheavy_automation

Basic build scripts for iheavy.com wordpress site.
Manage wordpress software & module install versions via php composer.
wpackagist is a repository managing wordpress plugins.

Required packages & versions in composer.json
AWS cloud init script in iheavy-user-data.sh

Did some testing with terraform build via iheavy.tf
To use the awscli, use the build_iheavy.sh script

Steps to Rebuild IHEAVY.COM

1. update iheavy/composer.json to change any versions
2. git commit -am "updated version x of php package"
3. git push origin master
4. ./build_iheavy.sh
5. add new ec2-52-23-236-12.compute-1.amazonaws.com to /etc/hosts
6. check www.newiheavy.com/wp-admin login
7. check www.newiheavy.com/wp-admin wp version
8. check www.newiheavy.com/wp-admin latest blog post
9. check www.newiheavy.com/wp-admin image content 
** AFTER TESTING!! **
10. update EIP configuration on aws dashboard