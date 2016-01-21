require "rubygems"
require 'mysql'
begin
  con = Mysql.new 'localhost', 'root', 'dinesh 770'
  con.query("CREATE DATABASE IF NOT EXISTS usershare") 
  con.close if con
end