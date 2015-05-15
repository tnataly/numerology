
#get '/people' do
#	erb :form
#end

get '/people/' do
  @people = Person.all	

  erb :"/people/index"
end

get '/people/new' do
  @person = Person.new
  erb :"/people/new"
end

get '/people/:id/edit' do
  @person = Person.find(params[:id])
  
  erb :"/people/edit"
end

put '/people/:id' do
  @person = Person.find(params[:id])
  
  if params[:birthdate].include?('-')
    birthdate = params[:birthdate]
  elsif params[:birthdate].respond_to?(:strftime)
    birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
  else
    birthdate = Time.now.strftime("%m%d%Y")
  end
  
  @person.attributes = { first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate }
  # check if user entered all the data
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @errors = ''
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}."
    end
    erb :"/people/edit"
  end
end

delete '/people/:id' do
  p = Person.find(params[:id])
  p.delete
  
  redirect "/people/"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  @magic_num = Person.adding_numbers_of_number(@person.birthdate.strftime("%m%d%Y"))
  @message = Person.message_output(@magic_num)

  erb :"/people/show"
end

post '/people/' do
	# if browser implements datepicker then '-' will be included in params[:birthdate], if not - handle this case
	if params[:birthdate].include?('-')
		birthdate = params[:birthdate]
	elsif params[:birthdate].respond_to?(:strftime)
		birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
  else
    birthdate = Time.now.strftime("%m%d%Y")
	end
	
 	@person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
  # check if user entered all the data
  if @person.valid?
    @person.save
  	redirect "/people/#{@person.id}"
  else
    @errors = ''
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}."
    end
    erb :"/people/new"
  end
end



