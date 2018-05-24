# iheavy_automation
 
* #### REPO NOTES ####

* Basic build scripts for iheavy.com wordpress site.
* Manage wordpress software & module install versions via php composer.
- wpackagist is a repository managing wordpress plugins.


* Required packages & versions in composer.json.  These include all of
the wordpress plugins currently installed.

* AWS cloud init script in iheavy-user-data.sh



* Cloud resources provisioned with terraform

* Server configuration management with ansible

* Makefile includes make test, make provision & make configure
options.  make all does all of them together.  :)

* Did some testing with terraform build via main.tf and vars.tf


* Steps to Rebuild IHEAVY.COM

1. update iheavy/composer.json to change any versions 
- still using the codecommit version, need to switch to github & test
2. git commit -am "updated version x of php package"
- need to test.  does this still use codecommit version of ihi infra?
- answer: yes :)
3. git push origin master (need to move this repo to github)
4. make test (runs terraform plan)
5. make provision (runs terraform apply)
6. make configure (runs ansible-playbook)
7. test upload media to wp
8. test a_simple_pingdom_test.php
9. these tests should be *automated*
- see TESTS.md for details

