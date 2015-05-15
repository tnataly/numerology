class Person < ActiveRecord::Base

validates_presence_of :first_name, :last_name, :birthdate

# Adds the number of birthdate to find a magic_num
def self.adding_numbers_of_number(string_number)
	
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

# Returns the message output depends on the computed earlier value of magic_num
def self.message_output(magic_num)
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

# Checks entering the valid value of birthdate
def self.valid_birthdate(input)
	if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
		return true
	else 
		return false
	end

end


end
