# CONTACT IMPORTER APP

![](https://github.com/mfcrespo/contacts_importer/blob/main/app/assets/images/contact_importer.gif)

This is a contacts importer app built in Ruby on Rails 6.1.

This app allows to user, to upload CSV files and validate the registers into CSV file.

## To run this project you have to run:

* git clone <repo>
* cd contacts_importer
* bundle install
* rails db:create
* rails db:migrate
* and run server: rails s

## Requirements
* Ruby 3.0
* Rails > 6.1
* Redis > 3.0

## Gem
* gem 'devise'
* gem 'shoulda-matchers'
* gem 'rspec-rails', '~> 5.0.0'
* gem 'rexml', '~> 3.2', '>= 3.2.5'
* gem 'rails-controller-testing'
* gem 'bcrypt'
* gem 'credit_card_validations'
* gem 'will_paginate', '~> 3.3'
* gem 'aasm'
* gem 'sidekiq'

### User and Test CSV File

To test the app, you can use this test user:
`Email: user@prueba.com`
`Password: 123456`

In the next link, you find test CSV file to testing:
1. [contacts_csv_finished.csv](https://github.com/mfcrespo/contacts_importer/blob/main/csv_example/contacts_csv_finished.csv): File with correct data.
2. [contacts_csv_finished.csv](https://github.com/mfcrespo/contacts_importer/blob/main/csv_example/contacts_csv_failed.csv): File with incorrect data.

#### Follow me 💬

| Authors | GitHub | Twitter | Linkedin |
| :---: | :---: | :---: | :---: |
| Maria Fernanda Crespo | [mfcrespo](https://github.com/mfcrespo) | [@mafe_crespo](https://twitter.com/mafe_crespo) | [mariafernandacrespo](https://www.linkedin.com/in/mariafernandacrespo) |

### License
*`Contacts Importer App ` is open source and therefore free to download and use without permission.*

##### MFCM
##### April, 2021. Cali, Colombia