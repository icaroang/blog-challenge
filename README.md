# README

## Requirements 

- Ruby 2.6.x
- Postgres 9.6.x 
- Nodejs
- Yarn

## Setup

1) Copy the sample environment variable file and change the values according to your credentials:

```
$ cp .env.example .env
```

2. Install the gems, create the database, run the migrations and run the seed

```
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

3. Install the packages

```
$ yarn install
```

4. Run the sidekiq (background processing)

```
$ bundle exec sidekiq
```

5. Run the application

```
$ rails s
```

## Tests

1) Run the tests

```
$ rspec spec/
```