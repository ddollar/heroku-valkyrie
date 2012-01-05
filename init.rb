$:.unshift File.expand_path("../lib/valkyrie/lib", __FILE__)
$:.unshift File.expand_path("../lib/sequel/lib", __FILE__)

require "valkyrie/cli"

class Heroku::Command::Db < Heroku::Command::Base

  # db:transfer FROM TO
  #
  # transfer data between databases
  #
  # Examples:
  #
  #   heroku db:transfer DATABASE_URL sqlite://data.db
  #   heroku db:transfer DATABASE_URL OTHER_DATABASE_URL
  #   heroku db:transfer sqlite://from.db postgres://to.db
  #
  def pull
    from = args.shift
    to   = args.shift
    error "Usage: heroku db:transfer FROM TO" unless from && to

    config = heroku.config_vars(app)
    from   = config[from] || from
    to     = config[to]   || to

    Valkyrie::CLI.start(from, to)
  end

end
