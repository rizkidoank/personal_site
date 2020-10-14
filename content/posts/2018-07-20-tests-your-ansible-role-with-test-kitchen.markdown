---

title: Test Your Ansible Role with Test Kitchen 
date: '2018-07-20 07:22:00'
tags:
- site-reliability-engineer
- configuration-management
- automation
- english
---

Its been a while I am using Ansible as a tool for configuration management.
There was some conditions where I created a roles with multiple dependencies,
or I have to revisit an ancient roles created by someone else in the past.
It doesn't matter if the roles are well tested, 
how if its untested or doesn't have tests at all?

In the past, I test ansible role by creating a vagrant box and run ansible playbook in it. After that, re-run the playbook and check by login into the box. The testing are created together with playbook creation. Which for me is very time consuming.

After look into some alternative, I finally found testing tool named Test Kitchen, part of ChefDK.

# Getting Started
In this article, I will demonstrate how to test ansible role using Test Kitchen using TDD with following steps:
1. Installing Test Kitchen
2. Create role skeleton
3. Create kitchen config
4. Create test specification
5. Create role
6. Run test

## Installing Test Kitchen
There are several way to install Test Kitchen, the simplest one is installing ChefDK package, and you are good to go:

```bash
# go to https://downloads.chef.io/chefdk, download your package, i.e ubuntu 18.04
wget https://packages.chef.io/files/stable/chefdk/3.1.0/ubuntu/18.04/chefdk_3.1.0-1_amd64.deb
dpkg -i chefdk_3.1.0-1_amd64.deb
```

Or, you can also install using ruby gem. Assuming you already have ruby in your system.
```bash
gem install test-kitchen kitchen-ansible kitchen-vagrant kitchen-inspec # use sudo if needed
```

Done, after that `kitchen` command will accessible.

## Create Role Skeleton
```bash
ansible-galaxy init ansible-jdk
```
## Create Kitchen Config
Initiate kitchen project by following command:
```bash
cd  ansible-jdk
kitchen init
mv -f tests/* test/
rm -Rf tests
```
After the initialization, `kitchen.yml` file will created. Open it and use the following content:
```
---
driver:
  name: vagrant
  cachier: true

platforms:
  - name: ubuntu-16.04
    driver:
      box: ubuntu/xenial64

provisioner:
  name: ansible_playbook
  hosts: all
  ansible_verbose: true
  require_chef_for_busser: false
  playbook: test/test.yml
  idempotency_test: true

verifier:
  name: inspec

suites:
- name: default
```

### Explanation
```
driver:
  name: vagrant
  cachier: true
```
We will use `vagrant` as a driver / test platform machine, and also enable `cachier` so we don't need to re-download repo update multiple times.

```
platforms:
  - name: ubuntu-16.04
    driver:
      box: ubuntu/xenial64
```
We will test it under Ubuntu Xenial 64 bit, `ubuntu/xenial64` refer to vagrant box of official Ubuntu.

```
provisioner:
  name: ansible_playbook
  hosts: all
  ansible_verbose: true
  require_chef_for_busser: false
  playbook: test/test.yml
```
Since we will use ansible playbook instead of chef recipe, then we have to set the provisioner to `ansible_playbook`. I enable `verbose` since its helpful for debugging and testing, and also set the playbook path and requirements path.

```
verifier:
  name: inspec

suites:
- name: default
```
We will use default verifier by test kitchen, `inspec`. This is a nice infrastructure testing and audit framework. For the suites, we will just use the default.

## Create Test Specification
Find the test suite dir in `test/integration/default`. Create a file named `spec.rb` and paste following contents:
```
describe package('openjdk-8-jdk-headless') do
  it { should be_installed }
end

describe command('/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java') do
  it { should be_exist }
end

describe command('java') do
  it { should be_exist}
end
```

## Create Role
Open `tasks/main.yml`, and paste with this content:
```
---
# tasks file for ansible-jdk
- block:
    - name: install java jdk
      apt:
        name: "openjdk-8-jdk-headless"
        update_cache: true
        state: present

    - name: set default java
      alternatives:
         name: java
         path: "/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"

    - name: add default-java symlink
      file:
        state: link
        src: "java-8-openjdk-amd64"
        dest: "/usr/lib/jvm/default-java"

  become: yes
  become_method: sudo
  remote_user: ubuntu
```
That was not a good playbook writing, please do modify by yourself, since its only used for an example.

## Run Test
We all good with everything, let's continue to the testing part.
Test Kitchen has four stage in its automation, `create`, `converge`, `verify`, `destroy`. There are multiple way to do full cycle test:
```
kitchen test
```
which will do all those commands in one command, and also:
```
kitchen create
kitchen converge
kitchen verify
kitchen destroy
```
by using multiple commands for each stage, in automation / pipeline I usually use last method because we can specify when we have to do each stage.

### Example Outputs of Test Kitchen
In `kitchen converge` idempotency test enabled, you will get this if your playbook idempotent:
```
Going to invoke ansible-playbook second time:
       Using /etc/ansible/ansible.cfg as config file
       
       PLAY [localhost] ***************************************************************
       
       TASK [Gathering Facts] *********************************************************
       ok: [localhost]
       
       TASK [ansible-jdk : install openjdk] *******************************************
       ok: [localhost] => {"cache_update_time": 1532043544, "cache_updated": true, "changed": false}
       
       TASK [ansible-jdk : set openjdk as default java] *******************************
       ok: [localhost] => {"changed": false}
       
       TASK [ansible-jdk : add default-java symlink] **********************************
       ok: [localhost] => {"changed": false, "dest": "/usr/lib/jvm/default-java", "gid": 0, "group": "root", "mode": "0777", "owner": "root", "size": 20, "src": "java-8-openjdk-amd64", "state": "link", "uid": 0}
       
       PLAY RECAP *********************************************************************
       localhost                  : ok=4    changed=0    unreachable=0    failed=0   
       
       Idempotence test: PASS
       Downloading files from <default-ubuntu-1804>
       Finished converging <default-ubuntu-1804> (3m32.31s).
```

And for verify stage, the output will be similiar with this one :
```
-----> Starting Kitchen (v1.22.0)
-----> Verifying <default-ubuntu-1804>...
       Loaded tests from {:path=>".Users.rizki.Documents.rizkidoank.ansible.ansible-jdk.test.integration.default"} 

Profile: tests from {:path=>"/Users/rizki/Documents/rizkidoank/ansible/ansible-jdk/test/integration/default"} (tests from {:path=>".Users.rizki.Documents.rizkidoank.ansible.ansible-jdk.test.integration.default"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2222

  System Package openjdk-8-jdk-headless
     ✔  should be installed
  Command /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
     ✔  should be exist
  Command java
     ✔  should be exist

Test Summary: 3 successful, 0 failures, 0 skipped
       Finished verifying <default-ubuntu-1804> (0m1.18s).
-----> Kitchen is finished. (0m3.84s)
```

# Conclusion
So far, personally Test Kitchen is the best testing framework for infrastructure. Not only used it for Ansible role testing, I also used it in CI such as for automated image building, and also for post provisioning test when using terraform in example. This framework enabling you to do TDD for your infra provisioning and might improve your code quality, and reducing error for some points.

# References
1. https://github.com/test-kitchen/test-kitchen
2. https://github.com/neillturner/kitchen-ansible
3. https://www.inspec.io/