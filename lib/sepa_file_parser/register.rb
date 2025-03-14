# frozen_string_literal: true

require_relative './xml'

# Add registrations
## CAMT052
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.052.001.02', :camt052)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.052.001.08', :camt052)

## CAMT053
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.02', :camt053)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.04', :camt053)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.08', :camt053)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.10', :camt053)

## CAMT054
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.054.001.02', :camt054)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.054.001.04', :camt054)

## PAIN001
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.001.001.03', :pain001)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.001.001.09', :pain001)

## PAIN002
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.002.001.03', :pain002)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.002.001.10', :pain002)

## PAIN008
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.008.003.02', :pain008)
SepaFileParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:pain.008.001.08', :pain008)
