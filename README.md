# SepaFileParser

[![Ruby CI](https://github.com/viafintech/sepa_file_parser/actions/workflows/test.yml/badge.svg)](https://github.com/viafintech/sepa_file_parser/actions/workflows/test.yml)

SepaFileParser is a Ruby Gem which does some basic parsing of sepa files, such as camt052, camt053, pain001, pain002, and pain008 files into an object
structure for easier usability instead of having to use an XML parser all the time.
Keep in mind that this might not include a complete parsing of camt specification.
Fields that we did not need for our use-cases are simply ignored for now.

## Getting started

1. add the Gem to the Gemfile

```ruby
gem 'sepa_file_parser'
```

2. Require the Gem at any point before using it
3. Use it!

## Example for camt053
```ruby
camt = SepaFileParser::File.parse path_to_file
puts camt.group_header.creation_date_time
camt.statements.each do |statement|
  puts statement.account.iban
  statement.entries.each do |entry|
    # Access individual entries/bank transfers
    puts entry.amount
    entry.transactions.each do |transaction|
      puts transaction.debitor
    end
  end
end
```

Please check the code for fields not mentioned here.
Also check the code for other file formats.

## Registering new namespaces
In case you have to parse a namespace which is generally compatible with any of the camt parsers, it is possible to register additional namespaces, without requiring a change to this gem.
```ruby
# Registering a new camt052 namespace
SepaFileParser::Xml.register('<your namespace>', :camt052)
# Registering a new camt053 namespace
SepaFileParser::Xml.register('<your namespace>', :camt053)
# Registering a new camt054 namespace
SepaFileParser::Xml.register('<your namespace>', :camt054)
# Registering a new pain001 namespace
SepaFileParser::Xml.register('<your namespace>', :pain001)
# Registering a new pain002 namespace
SepaFileParser::Xml.register('<your namespace>', :pain002)
# Registering a new pain008 namespace
SepaFileParser::Xml.register('<your namespace>', :pain008)
```

## Bugs and Contribution
For bugs and feature requests open an issue on Github. For code contributions fork the repo, make your changes and create a pull request.

### License
[LICENSE](LICENSE)
