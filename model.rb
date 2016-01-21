require 'sinatra'
require 'data_mapper'
require 'dm-core'
require 'dm-paperclip'
APP_ROOT = File.expand_path(File.dirname(__FILE__))

DataMapper.setup(:default, ENV['DATABASE_URL'] ||"postgres://postgres:dinesh 770@localhost/usershare")

class Employee
  include DataMapper::Resource
  property :group_name, String
  property :id, Serial
  property :first_name, String
  property :middle_name, String
  property :last_name, String
  property :gender, String
  property :address, String
  property :mobile_number,String
  property :email, String
  property :password, String
  property :position, String
  has n, :employee_share_file,:constraint => :destroy
  has n, :share_file, :through => :employee_share_file
  has n, :employee_share_text,:constraint => :destroy
  has n, :share_text, :through => :employee_share_text
  has n, :group_employee,:constraint => :destroy
  has n, :group, :through => :group_employee
end

class Group
  include DataMapper::Resource
  property :id, Serial
  property :group_name, String
  property :group_password, String
  property :admin_name, String
  has n,  :group_employee
  has n,  :employee, :through => :group_employee
  has n, :group_share_file
  has n, :share_file, :through => :group_share_file
  has n, :group_share_text
  has n, :share_text, :through => :group_share_text
end

class GroupEmployee
  include DataMapper::Resource
  property :id, Serial
  belongs_to  :group, :key => true
  belongs_to  :employee, :key => true
end

class ShareText
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  property :tags, String
  property :share_text, String 
  has n, :employee_share_text
  has n, :employee, :through => :employee_share_text
end

class ShareFile
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial 
  property :tags, String
  has_attached_file :file,
                        :url => "/:attachment/:style/:basename.:extension",
                        :path => "#{APP_ROOT}/public/:attachment/:style/:basename.:extension"
  has n, :employee_share_file
  has n, :employee, :through => :employee_resource
end

class EmployeeShareFile
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_file, :key => true
  belongs_to :employee, :key => true
end

class GroupShareFile
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_file, :key => true
  belongs_to :group, :key => true
end

class GroupShareText
include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_text, :key => true
  belongs_to :group, :key => true
end
class GroupEmployee
  include DataMapper::Resource
  property :id, Serial
  belongs_to  :group
  belongs_to  :employee
end

class EmployeeShareText
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_text, :key => true
  belongs_to :employee, :key => true
end

DataMapper.finalize 
DataMapper.auto_upgrade!

