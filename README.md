# TTPS Ruby 2017

![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Heroku](https://img.shields.io/badge/heroku-%23430098.svg?style=for-the-badge&logo=heroku&logoColor=white)

## Requirements
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ruby](https://www.ruby-lang.org/es/)
- [Bundle gem](https://github.com/bundler/bundler)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installing the Project

To install the project, it's necessary to open the terminal and execute the following commands:

```sh
git clone git@github.com:francoborrelli/TTPS-Ruby.git
cd TTPS-Ruby
docker-compose build
```

## Running the Project

To run the project, you need to be positioned in the project folder and execute the commands:

```sh
docker-compose up -d
docker-compose exec web rails db:setup
```

Once this is done, you can access the site from http://localhost:3000, with the username `admin` and the password `123456`.

## Running the Tests

To run all tests together using the command:
```sh
docker-compose exec web rails test
```
To run them one by one:
```sh
docker-compose exec web rails test test/models/course_test.rb
docker-compose exec web rails test test/models/examination_test.rb
docker-compose exec web rails test test/models/student_test.rb
docker-compose exec web rails test test/models/score_test.rb
```

## Finishing

To finish, it is necessary to execute:

```sh
docker-compose down
```
