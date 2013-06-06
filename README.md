[![Gem Version](https://badge.fury.io/rb/sql.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/sql.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/sql.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/sql.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/sql/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/sql
[travis]: https://travis-ci.org/dkubb/sql
[gemnasium]: https://gemnasium.com/dkubb/sql
[codeclimate]: https://codeclimate.com/github/dkubb/sql
[coveralls]: https://coveralls.io/r/dkubb/sql

sql.rb
======

SQL Parser and Generator for Ruby

Installation
------------

With Rubygems:

```bash
$ gem install sql
$ irb -rubygems
>> require 'sql'
=> true
```

With git and local working copy:

```bash
$ git clone git://github.com/dkubb/sql.git
$ cd sql
$ rake install
$ irb -rubygems
>> require 'sql'
=> true
```

Contributing
-------------

* If you want your code merged into the mainline, please discuss the proposed changes with me before doing any work on it. This library is still in early development, and the direction it is going may not always be clear. Some features may not be appropriate yet, may need to be deferred until later when the foundation for them is laid, or may be more applicable in a plugin.
* Fork the project.
* Make your feature addition or bug fix.
  * Follow this [style guide](https://github.com/dkubb/styleguide).
* Add specs for it. This is important so I don't break it in a future version unintentionally. Tests must cover all branches within the code, and code must be fully covered.
* Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Run "rake ci". This must pass and not show any regressions in the metrics for the code to be merged.
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright &copy; 2013 Dan Kubb. See LICENSE for details.
