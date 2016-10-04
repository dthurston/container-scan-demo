#!/bin/bash

touch /tmp/csd-repos
touch /tmp/csd-centos-mirror

if ! [ -e /tmp/csd-repos ];
then
  #subscription-manager register --auto-attach --username=user --password=passwd
  subscription-manager repos --enable rhel-server-rhscl-7-rpms
  subscription-manager repos --enable rhel-7-server-optional-rpms
  touch /tmp/csd-repos
fi

if ! [ -e /tmp/csd-centos-mirror ];
then
  yum-config-manager --add-repo=http://mirror.centos.org/centos-7/7/sclo/x86_64/sclo/
  echo "gpgcheck=0" >> \
    /etc/yum.repos.d/mirror.centos.org_centos-7_7_sclo_x86_64_sclo_.repo
  touch /tmp/csd-centos-mirror
fi

#yum groupinstall "Virtualization Host"
#systemctl start libvirtd
#systemctl enable libvirtd

#yum install sclo-vagrant1 sclo-vagrant1-vagrant-libvirt \
#  sclo-vagrant1-vagrant-libvirt-doc

#cp /opt/rh/sclo-vagrant1/root/usr/share/vagrant/gems/doc/vagrant-libvirt-*/polkit/10-vagrant-libvirt.rules \
#  /etc/polkit-1/rules.d

#systemctl restart libvirtd
#systemctl restart polkit

#vagrantgroup=`id | grep vagrant`
#echo $vagrantgroup
#if [ -z $vagrantgroup ];
#echo '''
#In another shell, perform the following steps to add your user to the vagrant group:
#$ echo $USER
#$ su -
#Password:
# usermod -a -G vagrant <username>
#'''

#if [ -z $vagrantgroup ];
#read keypress

cd ~
echo `pwd`
scl enable sclo-vagrant1 bash

#echo 'Download the "Red Hat Container Tools" and "RHEL 7.2 Vagrant box for libvirt"'
#echo 'from the following link: https://access.redhat.com/downloads/content/293/'
#read keypress

#cd
#unzip ~/Downloads/cdk-2.2.0.zip

#cd ~/cdk/plugins/
#vagrant plugin install \
#  ./vagrant-registration-*.gem \
#  ./vagrant-service-manager-*.gem \
#  ./vagrant-sshfs-*.gem

echo "The following plugins are installed";
vagrant plugin list

#vagrant box add --name cdkv2 \
#  ~/Downloads/rhel-cdk-kubernetes-7.2-*.x86_64.vagrant-libvirt.box
echo "Starting CDK....";
cd ~/cdk/components/rhel/misc/shared_folder/rhel-ose/
vagrant up;
