# Inherited Resources Views

## Introduction

Using [Inherited Resources][] is an excellent way to reduce the amount of repetition in your controllers. But what about views? A lot of times resources share the same views, so why not DRY 'em up using Inherited Resources Views!


## Difference to Other Seemly Similar Projects

If you are confused about the difference to some other similarly named projects, please read on.

### Difference to Inherit Views

[Inherit Views](http://github.com/ianwhite/inherit_views) adds the ability to render views from parent controllers. It does not share views between different resources.

### Difference to Inherited Views

[Inherited Views](http://github.com/gregbell/inherited_views) tries to solve the same problem we're solving, but from a slightly different angle. It is more complex, requires [Formtastic](http://github.com/justinfrench/formtastic) and [WillPaginate](http://github.com/mislav/will_paginate), and it only generates erb templates. **Inherited Resources Views** on the other hand, is extremely simple, is library-agnostic (it only depends on [Inherited Resources][]), and it supports both erb and [haml](http://github.com/nex3/haml) templates.


## Dependencies

* [Inherited Resources][]


## Installation

Add it to your `Gemfile`:

    gem 'mitio-inherited_resources_views'

Install using `bundle`:

    bundle install

You also need to require the proper library in order to "inject" the necessary code into `ActionView`. For example, in a file under `config/initializers` add the following code:

	require 'inherited_resources_views'

## Usage

It is *extremely* simple to use Inherited Resources Views. The only step you need to do after the installation is to customise the default views:

    rails generate inherited_resources_views

This will generate a set of views in your `app/views/inherited_resources` folder. Edit away!

**Note:** Please remember to restart your server!


## Bugs and Feedback

If you discover any bugs or have some idea, feel free to create an issue on GitHub:

* here: <https://github.com/mitio/inherited_resources_views/issues>
* or here: <https://github.com/jweslley/inherited_resources_views/issues>


## Authors

* Fred Wu <http://fredwu.me>
* Envato - <http://envato.com>
* Wuit - <http://wuit.com>
* Jonhnny Weslley - <http://jonhnnyweslley.net>


## License

Copyright (c) 2011 Jonhnny Weslley (<http://jonhnnyweslley.net>), released under the MIT license.

See the [MIT-LICENSE][] file provided with the source distribution for full details.


[Inherited Resources]: http://github.com/josevalim/inherited_resources
[MIT-LICENSE]: https://github.com/jweslley/inherited_resources_views/blob/master/MIT-LICENSE
