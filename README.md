## Installation

Prior to installation, make sure you have the following installed on your machine.
* `Ruby 2.7.3`
* `gem bundler`

In order to install the app follow these steps:

```shell
$ git clone https://github.com/in-hale/takehome-socials.git
$ cd takehome-socials
$ bundle
```

## Server setup

Run the server locally:
```shell
$ run/socials.rb [<source_1> <source_2> ... <source_N>]
```
Sources should be formatted like the following:
```
<name> <key> <url>

* name - name of the source, will be used as a reference
* key  - key for the source, will be used in the resulting JSON object
* url  - web-address of the source
```
Examples:
```shell
$ run/socials.rb 'reddit threads https://some_reddit_url.com' \
                 'pinterest photos https://test_pinterest.com'
```
The application has default sources configured:
```
1. name: 'twitter', key: 'tweets', url: 'https://takehome.io/twitter'
2. name: 'facebook', key: 'posts', url: 'https://takehome.io/facebook'
```
Which means that you can just run:
```shell
$ run/socials.rb
```

## Usage

In order to get the summary on the scraped social networks, you'll have to make a request to the server:
```shell
$ curl localhost:3000[?<source_name_1>,<source_name_2>]
```
Say you need a summary only on Facebook, you'll have to run the following:
```shell
$ curl localhost:3000?facebook
```
The server has default sources configured for summary:
```
1. twitter
2. facebook
```
Which means that in order to get the summary on them, you'll have to only run:
```shell
$ curl localhost:3000
```

## Specs and testing

In order to run the whole test suit you'll have to execute the following:
```shell
$ rspec
```
Add a `-fd` flag to see a meaningful output:
```shell
$ rspec -fd
```
Run the linter for the whole project with the following command:
```shell
$ rubocop
```

## Troubleshooting

In case you are having issues with running the executable file, make sure the file has the execution permission configured:
```shell
$ chmod +x run/socials.rb
```

## Possible improvements

* Better spec coverage
  * Integration request spec
  * Other missed unit tests
* If services (scraped social networks) start holding the requests randomly (with `sleep` or other) and the fetch time for the application is crucial, implement the following:
  * In threads, do N identical requests for each source
  * Process the first one that succeeds, cancel the others
* Handle connection-timeouts
