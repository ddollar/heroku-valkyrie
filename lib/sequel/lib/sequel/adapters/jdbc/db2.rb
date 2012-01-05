Sequel.require 'adapters/shared/db2'
Sequel.require 'adapters/jdbc/transactions'

module Sequel
  module JDBC
    class Database
      # Alias the generic JDBC versions so they can be called directly later
      alias jdbc_schema_parse_table schema_parse_table
      alias jdbc_tables tables
      alias jdbc_views views
      alias jdbc_indexes indexes
    end
    
    # Database and Dataset instance methods for DB2 specific
    # support via JDBC.
    module DB2
      # Database instance methods for DB2 databases accessed via JDBC.
      module DatabaseMethods
        include Sequel::DB2::DatabaseMethods
        include Sequel::JDBC::Transactions
        IDENTITY_VAL_LOCAL = "SELECT IDENTITY_VAL_LOCAL() FROM SYSIBM.SYSDUMMY1".freeze
        
        %w'schema_parse_table tables views indexes'.each do |s|
          class_eval("def #{s}(*a) jdbc_#{s}(*a) end", __FILE__, __LINE__)
        end

        private
        
        def last_insert_id(conn, opts={})
          statement(conn) do |stmt|
            sql = IDENTITY_VAL_LOCAL
            rs = log_yield(sql){stmt.executeQuery(sql)}
            rs.next
            rs.getInt(1)
          end
        end
      end
      
      # Dataset class for DB2 datasets accessed via JDBC.
      class Dataset < JDBC::Dataset
        include Sequel::DB2::DatasetMethods
      end
    end
  end
end
