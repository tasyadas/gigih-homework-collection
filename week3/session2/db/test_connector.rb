require 'mysql2'

def create_db_client
    client = Mysql2::Client.new(
        :host     => "localhost",
        :username => "root",
        :password => "tasyadas",
        :database => "db_yabb_latihan_unit_test"
    )

    client
end
