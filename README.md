# heroku-valkyrie

Transfer data between databases

## Installation

    heroku plugins:install http://github.com/ddollar/heroku-valkyrie.git


## Usage

    Usage: heroku db:transfer FROM TO

     transfer data between databases

     Examples:

       heroku db:transfer DATABASE_URL sqlite://data.db
       heroku db:transfer DATABASE_URL OTHER_DATABASE_URL
       heroku db:transfer sqlite://from.db postgres://to.db

## License

MIT
