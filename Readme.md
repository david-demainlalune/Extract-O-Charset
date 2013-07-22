# Extract-O-Charset

this is a web service that computes the set of unique characters from a utf-8 encoded text. it generates a report splitting the char set in the following subsets: lower case letters, upper case letters, digits, and everything else (punctuation). Whitespaces and newlines are rejected.

built with camping (a ruby web microframework), angularJs and twitter bootstrap.

## installation

bundle install

## run local server

bundle exec camping extract_charset_service.rb

## heroku files

confi.ru and procfile are required for heroku deployment

## tests

minitests exist for the ExtractCharset module
use the following command to run them

run ruby spec/extract_spec.rb

## todo 

add integration tests


