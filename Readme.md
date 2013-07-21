# Extract-O-Charset

this is a web service that allows the extraction of the set of all unique characters with the exception of whitespaces and newlines.
it generates a report splitting the char set in the following subsets: lower case letters, upper case letters, digits, and everything else (punctuation).

built with camping (a ruby web microframework), angularJs and twitter bootstrap.

## installation

bundle install

## run local server

bundle exec camping extract_charset_service.rb

## heroku files

confi.ru and procfile are required for heroku deployment

## todo 

add tests!!


