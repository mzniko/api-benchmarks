# API Benchmarks

This repository provides applications in various Ruby web frameworks for the purposes of easy benchmarking. All benchmarks are currently run using [wrk][wrk], though more benchmarking tools may be used in the future.

## Setup

Here's the software used to run these benchmarks:

* [Ruby 2.1.1][ruby] (with bundler: `gem install bundler`)
* [PostgreSQL][postgresql]
* [wrk][wrk]

If one of these isn't installed:

```bash
# Ruby
$ brew install chruby ruby-install
$ ruby-install ruby 2.1.1
$ chruby ruby-2.1

# PostgreSQL
$ brew install postgresql

# wrk
$ brew install wrk
```

## Running benchmarks

First, set up the benchmarking database:

```bash
$ bundle install
$ bundle exec rake db:setup
```

Then, you can run benchmarks:

```bash
$ rake benchmark:all

# Or, run benchmarks for one framework
$ rake benchmark:rails
```

### Benchmarking Information

All applications boot via `rackup` using the [Puma][puma] dispatcher. Each application defines three endpoints:

 * `/posts` (renders 100 posts as JSON)
 * `/posts/:id` (renders a single post as JSON)
 * `/posts/:id/comments` (renders 25 comments on a single post as JSON)

Each endpoint is hit consecutively for 10 seconds using `wrk -t 2 -c 10 -d 10S`.

## Results

Note: _I've ordered results by what I believe is the more important metric: Requests/sec_

### `/wiggles`

| Framework      | Requests | Response Time | Requests/sec |
|----------------|----------|---------------|--------------|
| [Rails][rails] |      969 |      103.18ms |        96.86 |

### `/wiggles/:id`

| Framework      | Requests | Response Time | Requests/sec |
|----------------|----------|---------------|--------------|
| [Rails][rails] |     4146 |       24.24ms |       414.56 |

### `/wiggles/:id/comments`

| Framework      | Requests | Response Time | Requests/sec |
|----------------|----------|---------------|--------------|
| [Rails][rails] |     1814 |       53.88ms |       181.38 |

### System Information

These benchmarks are run on a 15" Retina MacBook Pro with the following specifications:

 * CPU: 2.3 GHz Intel Core i7
 * RAM: 16 GB 1600 MHz DDR3
 * GPU: Intel HD Graphics 4000 1024 MB
 * OS: Mac OS X 10.9.2

[rails]: https://github.com/rails/rails
[postgresql]: http://www.postgresql.org
[puma]: https://github.com/puma/puma
[ruby]: https://github.com/ruby/ruby
[wrk]: https://github.com/wg/wrk