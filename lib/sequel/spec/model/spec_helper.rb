require 'rubygems'
unless Object.const_defined?('Sequel')
  $:.unshift(File.join(File.dirname(File.expand_path(__FILE__)), "../../lib/"))
  require 'sequel/core'
end
unless Sequel.const_defined?('Model')
  $:.unshift(File.join(File.dirname(File.expand_path(__FILE__)), "../../lib/"))
  require 'sequel/model'
end

if ENV['SEQUEL_COLUMNS_INTROSPECTION']
  Sequel.extension :columns_introspection
  Sequel::Dataset.introspect_all_columns
end

Sequel.quote_identifiers = false
Sequel.identifier_input_method = nil
Sequel.identifier_output_method = nil

class << Sequel::Model
  attr_writer :db_schema
  alias orig_columns columns
  def columns(*cols)
    return super if cols.empty?
    define_method(:columns){cols}
    @dataset.instance_variable_set(:@columns, cols) if @dataset
    def_column_accessor(*cols)
    @columns = cols
    @db_schema = {}
    cols.each{|c| @db_schema[c] = {}}
  end
end

Sequel::Model.use_transactions = false

db = Sequel.mock(:fetch=>{:id => 1, :x => 1}, :numrows=>1, :autoid=>proc{|sql| 10})
def db.schema(*) [[:id, {:primary_key=>true}]] end
def db.reset() sqls end
Sequel::Model.db = MODEL_DB = db
