[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html) [![Build Status](https://travis-ci.org/simp/pupmod-simp-mcafee.svg)](https://travis-ci.org/simp/pupmod-simp-mcafee) [![SIMP compatibility](https://img.shields.io/badge/SIMP%20compatibility-4.2.*%2F5.1.*-orange.svg)](https://img.shields.io/badge/SIMP%20compatibility-4.2.*%2F5.1.*-orange.svg)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - A Puppet module for managing mcafee](#module-description)
3. [Setup - The basics of getting started with pupmod-simp-mcafee](#setup)
    * [What pupmod-simp-mcafee affects](#what-simp-mcafee-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## This is a SIMP module
This module is a component of the
[System Integrity Management Platform](https://github.com/NationalSecurityAgency/SIMP),
a compliance-management framework built on Puppet.

If you find any issues, they can be submitted to our
[JIRA](https://simp-project.atlassian.net/).

Please read our [Contribution Guide](https://simp-project.atlassian.net/wiki/display/SD/Contributing+to+SIMP)
and visit our [developer wiki](https://simp-project.atlassian.net/wiki/display/SD/SIMP+Development+Home).

## Module Description

This class installed the command line McAfee anti-virus scanner and configures
updates to be pulled from rsync.

## Setup

### What simp mcafee affects

`simp/mcafee` will install McAfee, create an /opt/mcafee_dat directory and use
`simp/rsync` to control the /opt/mcafee_dat contents. `simp/rsync` will use the
data contained in /srv/rsync/mcafee on the Puppet Master by default.

### Setup Requirements

`simp/mcafee` requires the `simp/simplib` and `simp/rsync` modules.

## Usage

To use this module, just include it as a class in hiera or manifests.

## Reference

### Public Classes
* mcafee

### `mcafee`

#### Parameters

* `rsync_server`: The rsync server used in the SIMP environment. Valid Options:
An IP Address or FQDN.

* `rsync_timeout`: The timeout in seconds to transfer the data. Valid Options:
Integer. Default: '2'

## Limitations

This module is only designed to work in RHEL or CentOS 6 and 7. Any other
operating systems have not been tested and results cannot be guaranteed.

# Development

Please see the
[SIMP Contribution Guidelines](https://simp-project.atlassian.net/wiki/display/SD/Contributing+to+SIMP).

General developer documentation can be found on
[Confluence](https://simp-project.atlassian.net/wiki/display/SD/SIMP+Development+Home).
Visit the project homepage on [GitHub](https://simp-project.com),
chat with us on our [HipChat](https://simp-project.hipchat.com/),
and look at our issues on  [JIRA](https://simp-project.atlassian.net/).
