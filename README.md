This installs or removes applications via steamcmd

Usage is boringly simple, and limited in scope:

```
steamcmd { 'The Lab':
  ensure => present,
  app_id => '450390',
}
```

Currently only works with app ids.  No proper API to do db lookups for
matching by name.

It will install it in the %programfiles(x86)%/Steam/steamapps/common/
directory unless specified otherwise, with the title of the declaration
becoming the folder name.
By default it uses anonymous authentication, so if you wish to login,
you will need to set anonymous to false and also supply a username and
password.
