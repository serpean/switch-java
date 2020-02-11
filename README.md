# Switch Java

When we work on multiple Java projects, it is propably that not all work on the same Java version.
I found some resources that explain how you can get differents versions, however it could be messy write all
of this commands each time you donwload a new version.

## Getting Started

These instructions have been tested on ubuntu 19.04

### Prerequisites

What things you need to install the software and how to install them
We are going to use `update-alternatives` and `update-java-alternatives`.
If you don't have the second command, make sure that you have already installed the following package.

```
sudo apt install java-commons
```

Your java installation should be on:
> /usr/lib/jvm/<instalation_folder>
I recommend call versions as `java-<version>-<sdk>`:
* java-8-oracle
* java-11-oracle
* java-11-openjdk

### Installing

A step by step series of configuration the script on your machine

First, dowload the files or get them throught git:

```
git clone https://github.com/serpean/switch-java.git
```
Check your Java's intallation path:   
```
$ tree -L 1 /usr/lib/jvm/
/usr/lib/jvm/
├── java-11-openjdk
├── java-11-oracle
└── java-8-oracle
```

In the next step, we can execute our fist command:

```
sudo gen_j_conf.sh <jdk-folder-name> <priority>
```
Example:
```
sudo gen_j_conf.sh java-8-oracle 20
```
The last step is execute file generated on `/usr/lib/jvm/<jdk-folder-name>/` 

You have RE-exceute this file each time you start a new console session if the Java version is not the default 
on your machine.

## Running the tests

To verify that all is correct execute:
```
java --version
```
and
```
echo $JAVA_HOME
```

## Authors

* **Sergio Pérez** - [Serpean](https://github.com/serpean)


## Acknowledgments

* https://gist.github.com/olagache/a2eff8b2bbc95e03280b
* https://aboullaite.me/switching-between-java-versions-on-ubuntu-linux/
* https://www.reddit.com/r/java/comments/9ualdq/why_did_java_11_jre_not_install_with_jdk_and/
* https://dev.to/thegroo/install-and-manage-multiple-java-versions-on-linux-using-alternatives-5e93   

