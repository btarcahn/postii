# postii (prototype)

master: [![Build Status](https://app.travis-ci.com/btarcahn/postii.svg?branch=master)](https://app.travis-ci.com/btarcahn/postii)

development: [![Build Status](https://app.travis-ci.com/btarcahn/postii.svg?branch=development)](https://app.travis-ci.com/btarcahn/postii)

**postii** is thought to be an application that supports create, fill, and submit
forms and surveys with ease. It's quite similar to Google Forms or Survey Monkey,
but you can retrieve what you've submitted by a tracking code, or revoke your 
submission even after you've submitted.

This is a prototype for the **postii** backend. 
I wrote this project to explore and learn Ruby on Rails myself.

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
* Authentication, authorization, and JSON Web Token (JWT)
 
## 1. Add a private key for hashing
**postii** uses a symmetric key hashing algorithm for authentication.
You'll need to add a private key for the algorithm to work.

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
Simply do this:

````
bin/rails db:migrate 
````
then:

````
bin/rails db:seed
bin/rails db:seed_err_msg
````

## 4. Create a user to bypass authentication
We'll create a new account to bypass authentication using `HTTP`.
You may use any HTTP client you want (e.g. Postman, Insomnia).


Send a `POST` request to `[root]/auth/sign_up` with these `json` parameters:
````
{
    "user": {
        "email": "any_valid_email@postii.com",
        "password": "@nyv@l1dPassword"
    
    }
}
````

In return, you'll receive a JWT. 
Simply use that token for any authentication requirements. 
You may need to attach the JWT to the header of your HTTP request.


# I'm stuck?
Simply contact me for support, or play around with the code. It's free, who cares?

# API reference
Please see the wiki of the project 
