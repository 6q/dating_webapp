Cellove - Dating site
=====================

Cellove is a dating site with chat and a uniq recomendations system.

Before start
------------

  * Clone the repository and bundle install
  * Copy config/application.example.yml to config/application.yml
  * Run rake db:setup and go out for a coffe, because you are loading all the towns in the world each time you seed the database.

Development practices
---------------------

  * Translations are possible with fast_gettext [https://github.com/grosser/fast_gettext]

Requirements
------------

  For the chat to work you must use Arrowchat and set it up in apache server into your localhost machine.
  The arrowchat software is stored in extras/arrowchat directory.

  Apache/PHP Setup on Mountain Lion: http://jason.pureconcepts.net/2012/10/install-apache-php-mysql-mac-os-x/

  User the config located in doc/config/apache2 to configure a vhost in your local machine that can run Arrowcaht and the app as a reverse proxy.

Starting server in work machine
------------

  `apachectl start`

  `mysql.server start`

  `rails s`

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

Deploy
------

Application is deployed in deploy user in the server under ~/public_html/cellove_production or ~/public_html/cellove_staging

Add id_rsa-cellove key to sshagent:

`chmod 0600 config/keypair/id_rsa-cellove`
`ssh-add config/keypair/id_rsa-cellove (Enter passphrase)`

Deploy to staging will deploy develop branch:

  `cap staging deploy`

Deploy to production will deploy master branch:

  `cap production deploy`

Other useful commands:

cap [staging|production] deploy:restart
cap staging|production] deploy:migrations

Translations
------------

Locales are stored in config/locales

 To update translation templates: `rake gettext:find`

Password protection
-------------------

If you want to remove the passwords edit app/controllers/application_controller.rb and edit authenticate method.

Chat
----

Chat admin is accesed in /arrowchat/admin

Username: admin
Pass: columbia

Theme is Cellove under `/public/arrowchat/themes/cellove`

Change there images, css

Admin
-----

Admin interface access using /admin

Username: admin
Pass: columbia


Extra
-----

  * application.yml config file could be found in ~/public_html/cellove_[env]/shared/config/application.yml
  * User uploaded images gets stored in: public/system/dragonfly/[environment]
