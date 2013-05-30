Cellove - Dating site
=====================

Cellove is a dating site with chat and a uniq recomendations system.

Development practices
---------------------

  * Translations are possible with fast_gettext [https://github.com/grosser/fast_gettext]

Requirements
------------

  For the chat to work you must use Arrowchat and set it up in apache server into your localhost machine.
  The arrowchat software is stored in extras/arrowchat directory.

  Apache/PHP Setup on Mountain Lion: http://jason.pureconcepts.net/2012/10/install-apache-php-mysql-mac-os-x/
  sudo apachectl start/stop/restart

Testing
-------

We use minitest for testing, with the help of [https://github.com/blowmage/minitest-rails] to integrate with rails.

Testing dirs: 

  test/
    controllers
    fixtures
    helpers
    integration
    mailers
    models
    routes

We are using Minitest::Spec so testing is BDD, there are some TDD legacy tests in models folder that should be migrated to spec at the time of editing.

References: 

[http://www.rubyinside.com/a-minitestspec-tutorial-elegant-spec-style-testing-that-comes-with-ruby-5354.html]
[http://bfts.rubyforge.org/minitest/MiniTest/Expectations.html]
[https://github.com/seattlerb/minitest]
