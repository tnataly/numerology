require 'sinatra'


#sinatra routes

def setup_index_view
	@birthdate = params[:birthdate]
	@magic_num = Person.adding_numbers_of_number(@birthdate.to_s)
	@message = Person.message_output(@magic_num)
	erb :numerology	
end

get '/messages' do
	@all_messages = Array.new
	(1..9).each do |i|
		@all_messages << Person.message_output(i.to_s) 
	end
	erb :messages
end

get '/about' do
	erb :about
end

get '/:birthdate' do 
	setup_index_view
end

get '/' do
	erb :form
end

post '/' do 
	#{}"#{params}"
	#setup_index_view
	#lets normalize user's input
	@birthdate = params[:birthdate].gsub("-","")
	if Person.valid_birthdate(@birthdate)
		@magic_num = Person.adding_numbers_of_number(@birthdate.to_s)
		redirect "/message/#{@magic_num}"
	else
		@error = 'You should enter a valid birthdate in the form of mmddyyyy.'
		erb :form
	end
end

get '/message/:magic_num' do
	@magic_num = params[:magic_num]
	@message = Person.message_output(@magic_num)
	@birthdate = "Oops, I've lost it somewhere" if @birthdate.nil?
	erb :numerology
end


