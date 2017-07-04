This installs or removes applications via steamcmd

Usage is boringly simple, and limited in scope:

```
steamcmd { '90':
  ensure => present,
}
```

Currently only works with app ids.  No proper API to do db lookups for
matching by name.
