REA site performance pre-interview task
=============


Provision a new application server and deploy the following application
-------
write configuration as code recipes in chef / puppet / ansible / babushka  / shell scripts to
- deploy this application onto a vanilla OS image (Centos/Fedora/Ubuntu/Debian/RHEL)
- use apache modpassenger  / unicorn nginx or whatever you like to serve up the application on port 80
- provision a web server with ruby to deploy the packaged Sinatra application
- ensure that the server is locked down and secure
- deploy the hello world application


Expected output
-------------
- chef / puppet  / ansible / babushka  / shell scripts that we can use to deploy the following application

 


To get this application working locally
=============

    git clone git://github.com/tnh/simple-sinatra-app.git
    shell $ bundle install
    shell $ bundle exec rackup

Mod passenger:
http://www.modrails.com/documentation/Users%20guide%20Apache.html

Unicorn nginx:
http://sirupsen.com/setting-up-unicorn-with-nginx/

James Griffis Results and Explanations
=============

I have tried to keep this playbook as simple as possible while also trying to use Ansibles core/extra modules before writing scripts,
That said i wrote a script to complete the bundle install, I also used "shell:" to install most of the gems as "gems:" does not support gloabal installations (I did this for simplicity's sake)

There are three roles in the playbook,

    common
    app
    ufw

The common role is designed mainly around the ability to easly extend the playbook into a multi node setup and does some basic configuration.

The app role configures the Ruby, Apache and mod_passenger enviroments it also copy's some basic apache configurations to minimise the need to ssh the node on first deploy.

The ufw role configure uncomplicated firewall to allow ssh traffic while limiting requests to ssh to 6 requests per 30 seconds to help protect against brute-force attacks on the ssh port, It also allows web traffic on port 80 to reach the Apache2 server. 

While it was no specificly required i also wrote a bash script to interact with the AWS EC2 api and deploy basic EC2 instances.

Usage:

    ./deploy_instance.sh dev
    or
    ./deploy_instance.sh prod
    and
    ./deploy_instance.sh help

To use the playbook to deploy the app you need to define you hosts in /etc/ansible/hosts as well as your ssh key's for each host if they are configured.

You can then edit Deploy/ansible/site.yaml and enter the username for the hosts you are running the roles on.

You can then start the play:

    ansible-playbook Deploy/ansible/site.yaml

Note: this playbook was written for ubuntu specificly [ubuntu-wily-alpha2-amd64-server-20150728.1 (ami-e9d091d3)](http://cloud-images.ubuntu.com/releases/wily/alpha-2/)
