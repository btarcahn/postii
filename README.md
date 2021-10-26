# postii (prototype)

master: [![Build Status](https://app.travis-ci.com/btarcahn/postii.svg?branch=master)](https://app.travis-ci.com/btarcahn/postii)

development: [![Build Status](https://app.travis-ci.com/btarcahn/postii.svg?branch=development)](https://app.travis-ci.com/btarcahn/postii)

**postii** is thought to be an application that supports create, fill, and submit
forms and surveys with ease. It's like an extended version of Google Forms or Survey Monkey,
in a way that after form submission, you'll get a **tracking code** that allows you to edit, add remarks, or
even revoke your submission.

This is a prototype for the **postii** backend, the project is still in development.

Author: Bach Tran.

Copyright: Apache 2.0 license.

# Tech components
* Ruby version: 3.0.2
* Rails: 6.1.4.1
* Database: PostgreSQL (or any database that Rails support)

# Build
Please first ensure the tech components above are met before proceeding.

## 0. Conceptual requirements
For complete beginners (like me), I sum up several topics you should know
before diving into this code. The list is not exhaustive.

* Ruby language.
* PostgreSQL.
* Ruby on Rails.
* bundler, gems.
* HTTP requests.
* API.
* Authentication, authorization, JSON Web Token, including `devise` gem
 
## 1. Add a private key for hashing
**postii** uses HSA-256 symmetric key hashing algorithm for signing the JWT.
You'll need to add a private key yourself for the algorithm to work. 

Keep your private key **secretly** in the environment variable `API_SECRET_KEY`. On many build systems,
it's easy enough to add `API_SECRET_KEY` directly, otherwise:

**On development environment only:** 
Create a file `.env` in the root folder, and add this in:

````
API_SECRET_KEY=<key_of_your_choice>
````
The `<key_of_your_choice>` could be anything you want, but I suggest you use a strong
key, a good place to find one is [here](https://randomkeygen.com).

## 2. Install gems
Nothing major here, just:
````
bundle install
````
and that should install the required gems for you.

## 3. Populating the database
For a fresh database, it's as simple as:

````
bin/rails db:setup
````

**if you need to** to reset the database (drop, create, migrate, seed), do:

````
bin/rails db:reset
````

### Additional database tasks (use only if needed)

````
bin/rails db:migrate # To migrate the database
bin/rails db:seed:{table} # To seed (applicable to some) table specifically
````


## 4. Add core records (skip if you're in the development environment)

Core records are essential objects to create **at least one** superuser, 
default alert messages, and make the public APIs (the ones that don't need 
authentications) works.

### Create core records

```` 
bin/rails db:core:setup
````

### Create superuser

A superuser is an acount that's given **ultimate power** to manipulate the
system through APIs. It can generally do full CRUD operations without any
restrictions. Therefore, please be careful when you login with a superuser.

To create a superuser, run:

```` 
bin/rails db:core:create_super_user[${email}, ${password}]
````

For example:

```` 
bin/rails db:core:create_super_user[super@p.com, I@maSuperUser]
````

For some system, passing `[` to bash causes a syntax error, in these cases, you
may use the `''` to annotate that you want to pass a string, for example:

```` 
bin/rails 'db:core:create_super_user[super@p.com, I@maSuperUser]'
````


# I'm stuck?
Simply contact me for support, or play around with the code. It's free, who cares?

# API reference
Please see the wiki of the project 
