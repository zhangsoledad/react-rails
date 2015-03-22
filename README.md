# react-rails [![Build Status](https://travis-ci.org/reactjs/react-rails.png)](https://travis-ci.org/reactjs/react-rails) [![Code Climate](https://codeclimate.com/github/reactjs/react-rails.png)](https://codeclimate.com/github/reactjs/react-rails)

react-rails is a ruby gem which makes it easier to use [React](http://facebook.github.io/react/) and [JSX](http://facebook.github.io/react/docs/jsx-in-depth.html) in your Ruby on Rails application.

This is done in 2 ways:

1. making it easy to include `react.js` as part of your dependencies in `application.js`.
2. transforming JSX into regular JS on request, or as part of asset precompilation.


## Installation

We're specifically targeting versions of Ruby on Rails which make use of the asset pipeline, which means Rails 3.1+.

As with all gem dependencies, we strongly recommend adding `react-rails` to your `Gemfile` and using `bundler` to manage your application's dependencies.

```ruby
# Gemfile

gem 'react-rails', '~> 0.13.0.1'
```


## Usage

### react.js

In order to use React client-side in your application, you must make sure the browser requests it. One way to do that is to drop `react.js` into `app/assets/javascript/` and by default your application manifest will pick it up. There are downsides to this approach, so we made it even easier. Once you have `react-rails` installed, you can just add a line into your config file (see Configuring) and require react directly in your manifest:

You can `require` it in your manifest:

```js
// app/assets/application.js

//= require react
```

Alternatively, you can include it directly as a separate script tag:

```erb
# app/views/layouts/application.erb.html

<%= javascript_include_tag "react" %>
```


### JSX

To transform your JSX into JS, simply create `.js.jsx` files. These files will be transformed on request, or precompiled as part of the `assets:precompile` task.


## Configuring

### Variants

There are 2 variants available. `:development` gives you the unminified version of React. This provides extra debugging and error prevention. `:production` gives you the minified version of React which strips out comments and helpful warnings, and minifies.

```ruby
# config/environments/development.rb
MyApp::Application.configure do
  config.react.variant = :development
end

# config/environments/production.rb
MyApp::Application.configure do
  config.react.variant = :production
end
```

### Add-ons

Beginning with React v0.5, there is another type of build. This build ships with some "add-ons" that might be useful - [take a look at the React documentation for details](http://facebook.github.io/react/docs/addons.html). In order to make these available, we've added another configuration (which defaults to `false`).

```ruby
MyApp::Application.configure do
  config.react.addons = true
end
```


## CoffeeScript

It is possible to use JSX with CoffeeScript. We need to embed JSX inside backticks so CoffeeScript ignores the syntax it doesn't understand. Here's an example:

```coffee
Component = React.createClass
  render: ->
    `<ExampleComponent videos={this.props.videos} />`
```
You can use the `--harmony` or `--strip-types` options by adding a configuration to `application.rb`:
```ruby
config.react.jsx_transform_options = {
  harmony: true,
  strip_types: true, # for removing Flow type annotations
}
```
