README
========

A Ruby client gem for [Cube](https://github.com/square/cube).

## Installation

Add this line to your application's Gemfile:

    gem 'cube', git: 'https://github.com/culturejam/cube-ruby-gem.git'

And then execute:

    $ bundle install


## Usage

You can run the gem in standalone using pry:

```sh
git clone https://github.com/culturejam/cube-ruby-gem.git
cd cube-ruby-gem
bundle install
bundle exec pry
```

Sample usage:

```ruby
require 'cube'

# Configure
Cube.url = "https://cube.promojam.com"
Cube.username = "cube"
Cube.password = "password"

# Get a client
cube = Cube.client

# Get metrics.
cube.client.get_metric('sum(pageviews)', start: "2014-04-01", step: "6e4", limit: 10)
```

## License

Copyright 2014 CultureJam, Inc.

Licensed under the Apache License, Version 2.0.
