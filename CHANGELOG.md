# v0.6.1

- Fix pain002 group_information_and_status
- Extend pain 002 parsing by additional fields

# v0.6.0

- Implement pain002 group information parsing

# v0.5.1

- prevent crash when creditor_identifier is missing

# v0.5.0

- Add general support for camt.052.001.08
- Better handling for creditor identifier for camt.053.001.08 and camt.052.001.08

# v0.4.0

- Add the following methods to general transaction:
  - `original_currency_amount` (`AmtDtls/InstdAmt/Amt/text()`)
  - `original_currency` (`AmtDtls/InstdAmt/Amt/@Ccy`)
  - `exchange_rate` (`AmtDtls/TxAmt/CcyXchg/XchgRate/text()`)

# v0.3.0

- Add `NtryRef` support for general entry

# v0.2.2

- Add pain.008.001.08 support

# v0.2.1

- Add support for pain.002.001.10

# v0.2.0

- Add general pain.002 support, specifically for pain.002.001.03

# v0.1.0

- Fork from [camt_parser](https://github.com/viafintech/camt_parser)
- Added general pain.001 and pain.008 support
