require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './model.rb'
require 'data_mapper'
require 'dm-core'
enable :sessions
get '/' do
  erb:index
end
get '/about' do
  erb:Aboutpage
end
get '/group' do
  erb:group
end
get '/loginGroup' do
  erb:loginGroup
end
get '/createGroup' do
  erb:createGroup, :locals => {
    :group_member=> Group.new
  }
end
post '/createGroup' do
  group_name=Group.first(:group_name=>"#{params[:group_name]}")
    if(group_name==nil)
      group_regist=Group.new
      group_regist.attributes =params
      group_regist.save
      @group=params[:group_name]
      @admin=params[:admin_name]
      erb:groupSuccess
    else
      erb:groupFail
    end
  end

get '/login' do
  if(session['status']==1)
    redirect("/search")
  else
    session['status']=0
    erb:login
  end
end

get '/register' do
  session['status']=0
  erb:register, :locals => {
     :employee_register=> Employee.new 
   }
end
get '/edit' do
  erb:edit
end

get '/delete' do
  erb:delete
end
get '/list' do
  @group_list= GroupEmployee.all(:group_id=>session['gid'])
  @employee_list=Employee.all
  erb:list
end

post '/edit' do
  @test=0
  @email=params[:email]
   group_register= Group.first(:id=>session['gid'])
  email_result=Employee.all(:email=>"#{params[:email]}")
  email_result.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
     @test=1
      @employee_register=email
      break
    end
  end
 erb:editResult
end

delete '/delete' do
  @test=0
 @email=params[:email]
   group_register= Group.first(:id=>session['gid'])
  email_result=Employee.all(:email=>"#{params[:email]}")
  email_result.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
      @test=1
      @employee_register=email
      break
    end
  end
  if(@test==1)
   Employee.get(@employee_register.id).destroy
 end
 erb:deleteResult
end

post '/update' do 
   test=0
   group_register= Group.first(:id=>session['gid'])
  email_result=Employee.all(:email=>"#{params[:email]}")
  email_result.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
      test=1
      @employee_register=email
      break
    end
  end
  if("#{params[:email]}"!="#{params[:user]}")
  email_test=Employee.all(:email=>"#{params[:user]}")
  email_test.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
      test=0
      break;
    end
  end
end
  if(test==0)
    erb:updateFail
  else
   
    email_update=Employee.first(:email=>@employee_register.email)
    email_update.update(:first_name => "#{params[:first_name]}",:last_name => "#{params[:last_name]}",:email => "#{params[:user]}",:mobile_number => "#{params[:mobile_number]}",:address => "#{params[:address]}",:password => "#{params[:password]}")
     email_result=Employee.all(:email=>"#{params[:user]}")
    email_result.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
      test=1;
      @employee_register=email
      break
    end
  end
    erb:update
  end
end



get '/logout' do
  session['status']=0
  redirect("/login")
end

post '/register' do
 session['status']=0
  group_register= Group.first(:id=>session['gid'])
  email_result=Employee.all(:email=>"#{params[:email]}")
  email_result.each do|email|
    group_email= GroupEmployee.first(:employee_id=>(email.id),:group_id=>session['gid'])
    if(group_email!=nil)
      session['status']=1
      break;
    end
  end
  if(session['status']==0)
    employee_register = Employee.new
    employee_register.attributes = params
    employee_register.save
    group_employee= GroupEmployee.new(:employee_id=>(employee_register.id),:group_id=>session['gid'])
    group_employee.save
    erb:success
  else 
    erb:register, :locals => {:employee_register=> Employee.new ,:c=>session['status']}
  end
end

post '/login' do
   session['status']=2
  password="#{params[:password]}"
  group_result=Group.first(:group_name=>"#{params[:group_name]}")
  if(group_result!=nil)
    session['status']=3
     employee_result = Employee.all(:email=>"#{params[:email]}")
     employee_result.each do|result|
      if(employee_result!=nil)
          group_employee_result=GroupEmployee.first(:group_id=>group_result.id,:employee_id=>result.id)
 
          if(group_employee_result!=nil)
             if(result.password == password)
                session['gid'] = group_result.id
                session['id']=result.id
                session['status']=1
                session['email']=result.email
              end
          end
      end
    end
end
  if(session['status']==1)
    redirect('/search')
  else
    erb:login, :locals => {:c=>session['status']}
  end
end

post '/loginGroup' do
   password = "#{params[:group_password]}"
   group_result = Group.first(:group_name=>"#{params[:group_name]}")
   if(group_result!=nil)
      if(group_result.group_password == password)
        session['gid'] = group_result.id
        session['status']=1
        session['group']=group_result.group_name
      else
        session['status']=2
      end
    else
      session['status']=2
    end
    if(session['status']==1)
      redirect('/register')
    else
      erb:loginGroup, :locals => {:c=>session['status']}
    end
  end


