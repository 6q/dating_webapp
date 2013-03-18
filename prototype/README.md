Structure
=============

To create new views, just add them to /views/* folder.

There you will find:

- /layouts/ with public and private base layout
- /public/ all public views
- /user/ all logged user views
- /shared/ all shared partials, also divided in /public/ and /user/

How do I install and run Serve?
-------------------------------

Serve is distributed as a Ruby gem to make it easy to get up and running. You
must have Ruby installed in order to download and use Serve. 

Once you have Ruby installed, open up the command prompt and type:

    gem install serve

(OSX and Unix users may need to prefix the command with `sudo`.)

It's also recommended to install bundler

	gem intall bundler

After everything is intalled, clone the project and run bundle install to get all gems.

When you're done, you just need to run

    bundle exec serve

And point your browser to

<http://localhost:3000>

By default, Serve runs on port 4000 but here we've removed this behaviour to allow heroku's deploy.


Learning More
-------------

You can learn more about Serve on the GitHub project page:

<http://github.com/jlong/serve>
