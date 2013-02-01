Description
===========
Chef recipe to install and configure the dcm4chee DICOM archive (http://www.dcm4che.org/confluence/display/ee2/Home)

Requirements
============
Java JDK, MySql

Attributes
==========

dcm4chee['database'] - Set the database will be used, default is mysql.

**Using MySQL**

* mysql['server_root_password'] - Set the server's root password with
this, default is 123456.
* mysql['server_repl_password'] - Set the replication user 'repl' password
with this, default is 123456.
* mysql['server_debian_password'] - Set the debian-sys-maint user password
with this, default is 123456.

Usage
=====
