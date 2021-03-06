# Habitat Workshop Environment

This repository is based on the Compliance Workshop Environment, and relies on the carpenter gem.

## Setup
* gem install carpenter

* If you haven't already, you will need Terraform installed.
This was last tested on version 0.11.3

* If you haven't already, you will need Packer installed.
This was last tested on version 1.1.3

* Ensure your ssh-agent is configured for your aws_key  
    `ssh-add -l`  

    If you don't see your AWS key then add it:  
    `ssh-add <aws_key>`  
     ex: `ssh-add ~/.ssh/kkw2-sa-west.pem`  

## Config updates

Name of current valid AMI as of 6/1/18:
* ami-f281fe8a / Habitat Workshop Workstation - CentOS 7 - v0.3 - 2018-05-21T15-09-09Z

AMIs do expire, so if its been a while and the AMI in the workstation.tf is no longer valid, go into EC2, and make a copy into a new one.  Then please update the .tf file and this README.

## Launching instances
Assuming `ssh-add -l` includes your aws_key

From the root directory of this repo, to generate an environment:

* bundle install 
* bundle exec carpenter build `<ENVNAME>`  
ex:  
    `bundle exec carpenter build GM_HAB_WRKSHP`

    If you want to get rid of that build:  
    `bundle exec carpenter destroy GM_HAB_WRKSHP`

### Workstations labels /w colors & suits

This program is setup to label workstations for workshop students. When it runs it will prompt you for a color and a # of workstations. You will then end up with Workstations in AWS us-west with names such as 'workstation-red-hearts-02'.

After all workstations have been generated then you can have the enjoyment of putting the name/IP info into a gist for the students to access.

### Example usage:
> `bundle install`  
> ......  
> Bundle complete! 1 Gemfile dependency, 16 gems now installed.  
> Use bundle info [gemname] to see where a bundled gem is installed.

> `bundle exec carpenter build kkw-hab-new2`      
> 1. chef-aws
> 2. chef-engineering
> 3. chef-sa-group
> Select an AWS account: 3    
> AWS Key Name (in us-west-2 on account chef-sa-group): |kkwentus| kkw2-sa-west

> Checking for valid AWS credentials... OK  
> Checking for your SSH key pair... OK  
> Checking for workstation AMI... OK  
> Checking for Automate server AMI... OK  
> Checking for security group... OK  
> Checking for DNS zone... OK   

> Login password for workstations: chefhab1!  
> Number of workstations: 1  

> Card deck color: |blue| red  
> Email, without the chef.io (i.e. adamleff): |kkwentus|  
> The following configuration will be used:  

> ......   

> module.deck-1-heart-workstations.aws_instance.workstation (remote-exec):   SSH Agent: true    
> module.deck-1-heart-workstations.aws_instance.workstation (remote-exec): Connected!
> module.deck-1-heart-workstations.aws_instance.workstation: Creation complete after 58s (ID: i-0f6c2c3b6b26248c8)  
> Apply complete! Resources: 20 added, 0 changed, 0 destroyed.  
> SUCCESS: Environment created!
