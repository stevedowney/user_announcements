# user_announcements

[![Gem Version](https://badge.fury.io/rb/user_announcements.png)](http://badge.fury.io/rb/user_announcements)
[![Build Status](https://travis-ci.org/stevedowney/user_announcements.png)](https://travis-ci.org/stevedowney/user_announcements)
[![Coverage Status](https://coveralls.io/repos/stevedowney/user_announcements/badge.png?branch=master)](https://coveralls.io/r/stevedowney/user_announcements?branch=master)
[![Code Climate](https://codeclimate.com/github/stevedowney/user_announcements.png)](https://codeclimate.com/github/stevedowney/user_announcements)

Manage and display site-wide announcements on a per-user basis.

Coming soon, scope by user role and announcement type.

### Acknowledgements
 
This gem was inspired by the [Site-Wide Announcements (revised)](http://railscasts.com/episodes/103-site-wide-announcements-revised)
episode of [RailsCasts](http://railscasts.com/).  If you don't have a premium account you can see the 
[original episode](http://railscasts.com/episodes/103-site-wide-announcements).

## Installation

Add it to your Gemfile:

```ruby
gem "user_announcements"
```

Run bundler:

```sh
bundle install
```

Install files:

```sh
rails generate user_announcements:install
```

## Configuration

There are several configuration settings.  All are found in:

```ruby
# ../config/initializers/user_announcements.rb

UserAnnouncements.config do |config|

  # note: all options accept lambdas
  
end
```

### Bootstrap

By default, Bootstrap styling is applied.  This can be turned on/off:

```ruby
# ../config/initializers/user_announcements.rb

c.bootstrap = false
```

### Roles

Roles are not enabled by default.  To enable roles support, set the roles configuration option:

```ruby

config.roles = ['', 'admin']
# config.roles = [ ['Public', ''], ['Administrator', 'admin'] ]
# config.roles = lambda { MyRoleClass.map { |role| [role.name, role.id] } }
```

### Default Values for Announcements

```ruby
config.default_active = true
config.default_starts_at = lambda { Time.now.in_time_zone }
config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
config.default_roles = ['admin']
config.default_style = ['alert-info']
```

Don't forget to restart your Rails server.

## Getting Going

To create an announcement go to:

```
http://<your app>/admin/announcements
```

To see the announcment add the helper method to your views, e.g.:

```erb
#../layouts/application.html.erb

<body>
  <%= user_announcements %>
  ...
```

Non-admin users can see (and unhide) announcements they have hidden:

```
http://<your app>/announcements
```
