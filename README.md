# user_announcements

[![Gem Version](https://badge.fury.io/rb/user_announcements.png)](http://badge.fury.io/rb/user_announcements)
[![Build Status](https://travis-ci.org/stevedowney/user_announcements.png)](https://travis-ci.org/stevedowney/user_announcements)
[![Coverage Status](https://coveralls.io/repos/stevedowney/user_announcements/badge.png?branch=master)](https://coveralls.io/r/stevedowney/user_announcements?branch=master)
[![Code Climate](https://codeclimate.com/github/stevedowney/user_announcements.png)](https://codeclimate.com/github/stevedowney/user_announcements)

## Features:

* admins
  * page for maintaining announcements
  * announcements can be scoped by user role
* users
  * hide announcements
  * view past and hidden announcements
  * unhide hidden announcements

### Acknowledgements
 
This gem was inspired by the [Site-Wide Announcements (revised)](http://railscasts.com/episodes/103-site-wide-announcements-revised)
episode of [RailsCasts](http://railscasts.com/).  If you don't have a premium account you can see the 
[original episode](http://railscasts.com/episodes/103-site-wide-announcements).

## Assumptions

* your controllers respond to `ensure_admin_user` which ensures only admin users can create/edit/delete
announcemets
* your controllers respond to `current_user`, which is also a `helper_method`
* if you implement roles, `current_user` responds to `#has_role?(<role>)`

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

## Getting Started

### Controller Methods Example

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def ensure_admin_user
    current_user.has_role?('admin')
  end
  
  def current_user
    @user ||= User.find(session[:user_id])
  end
  helper_method :current_user
  
end
```

### User Model Methods


```ruby
class User < ActiveRecord::Base
  
  def has_role?(role)
    return true if role.blank?
    return true if role == admin && self.admin?
    # ... more elaborate role checking code here?
    false
  end
  
end
```

### Create an Announcement

```
http://<your app>/admin/announcements
```

### View the Announcement

Add the helper method to your layout:

```erb
#../layouts/application.html.erb

<body>
  <%= user_announcements %>
  ...
```

Now visit some page that uses that layout to see the announcement.

Non-admin users can see current and past announcements, including ones they have hidden,
by visiting:

```
http://<your app>/announcements
```

## Configuration

There are several configuration settings found in `../config/initializers/user_announcements.rb`.

```ruby
# note: all options accept lambdas

UserAnnouncements.config do |config|

  # Bootstrap
  config.bootstrap = true
  config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]

  # non-Bootstrap
  # config.bootstrap = false
  # config.styles = [['Yellow', 'yellow'], ['Red', 'red'], ['Green', 'green'], ['Blue', 'blue']]

  # Announcement defaults
  config.default_active = true
  config.default_starts_at = lambda { Time.now.in_time_zone }
  config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
  config.default_style = ''
  # config.default_roles = ['admin']

  # Roles
  # config.roles = []
  # config.roles = ['', 'admin']
  # config.roles = [ ['Public', ''], ['Administrator', 'admin'] ]
  # config.roles = lambda { MyRoleClass.map { |role| [role.name, role.id] } }  
  
end
```

Don't forget to restart your Rails server after changes to the config file.

