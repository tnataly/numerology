require 'sinatra'

def adding_numbers_of_number(string_number)
	
	while string_number.length > 1 
		new_num = 0
		magic_num = string_number.chomp.split("").map{|s| s.to_i}
		magic_num.each do |b|
			new_num += b
		end
 		string_number = new_num.to_s
		
	end	

	return string_number
end

def message_output(magic_num)
  numerology = {
    "1" => { birthdate: "12151999", message: "One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."},
    "2" => { birthdate: "12161999", message: "This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon." },
    "3" => { birthdate: "12171999", message: "Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter." },
    "4" => { birthdate: "12181999", message: "This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus." },
    "5" => { birthdate: "12191999", message: "This is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury." },
    "6" => { birthdate: "12111999", message: "This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus." },
    "7" => { birthdate: "12121999", message: "This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune." },
    "8" => { birthdate: "12131999", message: "This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn." },
    "9" => { birthdate: "12141999", message: "This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars." }
  }  

  output = numerology[magic_num][:message]

  output = "Something is wrong. I couldnot find your number." if output.nil?
  #puts output
  return output
end

def valid_birthdate(input)
	if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
		return true
	else 
		return false
	end

end


=begin
magic_num = adding_numbers_of_number("26111985")
puts "Your numerology number is #{magic_num}"
message_output(magic_num.to_i)

=end
	


#sinatra routes
def setup_index_view
	@birthdate = params[:birthdate]
	@magic_num = adding_numbers_of_number(@birthdate.to_s)
	@message = message_output(@magic_num)
	erb :numerology	
end

get '/newpage/' do
	@all_messages = Array.new
	(1..9).each do |i|
		@all_messages << message_output(i.to_s) 
	end
	erb :newpage
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
	if valid_birthdate(@birthdate)
		@magic_num = adding_numbers_of_number(@birthdate.to_s)
		redirect "/message/#{@magic_num}"
	else
		@error = "Sorry, your input wasn't valid. Try again!"
		erb :form
	end
end

get '/message/:magic_num' do
	@magic_num = params[:magic_num]
	@message = message_output(@magic_num)
	@birthdate = "Oops, I've lost it somewhere" if @birthdate.nil?
	erb :numerology
end


