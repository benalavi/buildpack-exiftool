_Check out https://github.com/benalavi/buildpack-packages which is a more
up-to-date way to install `s3cmd` (and other simple binary packages) on Heroku._

Heroku buildpack that installs exiftool.

Installation
============

You probably want to compose this with other buildpack(s) using
heroku-buildpack-multi (https://github.com/ddollar/heroku-buildpack-multi):

Set your buildpack:

```
heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi
```

And add this to your `.buildpacks`, i.e.:

```
https://github.com/benalavi/buildpack-exiftool
https://github.com/heroku/heroku-buildpack-ruby
```

Usage
=====

Once built you will have `exiftool` available on `PATH`.

Testing
=======

`ruby test/buildpack_test.rb`

There is also a `Vagrantfile` which will set up a VM with the build/test
environment ready to go:

```
vagrant up
vagrant ssh
cd /vagrant
ruby test/buildpack_test.rb
```

exiftool-9.40 package
---------------------

The exiftool-9.40 package this buildpack installs is available at
https://s3.amazonaws.com/buildpack-exiftool/exiftool-9.40.tar.gz.

It is simply a repackaged version of the one available at
http://www.sno.phy.queensu.ca/~phil/exiftool/ with only the exiftool binary and
required `lib` folder included.
