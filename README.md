# user_announcements

Manage and display site-wide announcements on a per-user basis.

Coming soon, scope by user role and announcement type.

## Installation

Add it to your Gemfile:

```ruby
gem "bootstrap-view-helpers"
```

Run bundler:

```sh
bundle install
```

Install files:

```sh
rails generate user_announcements:install
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
