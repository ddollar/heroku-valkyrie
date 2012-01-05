# heroku-valkyrie

Transfer data between databases

## Installation

    heroku plugins:install http://github.com/ddollar/heroku-valkyrie.git

## Help

    Usage: heroku db:transfer FROM TO

     transfer data between databases

     Examples:

       heroku db:transfer DATABASE_URL sqlite://data.db
       heroku db:transfer DATABASE_URL OTHER_DATABASE_URL
       heroku db:transfer sqlite://from.db postgres://to.db

## Usage

    $ heroku db:transfer DATABASE_URL postgres://localhost/myapp_development
    Transferring 5 tables:
    delayed_jobs:   100% |=========================================| Time: 00:00:00
    messages:       100% |=========================================| Time: 00:00:00
    participants:   100% |=========================================| Time: 00:00:02
    schema_migrati: 100% |=========================================| Time: 00:00:00
    settings:       100% |=========================================| Time: 00:00:00
