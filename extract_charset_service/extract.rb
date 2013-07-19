#!/usr/local/bin/env ruby -KU
# encoding: UTF-8

require 'set'


module ExtractCharset
	def ExtractCharset.is_digit?(c)
		!!(/\d/ =~ c)
	end

	def ExtractCharset.is_whitespace?(c)
		!!(/[[:space:]]/ =~ c)
	end

	def ExtractCharset.is_lower_case?(c)
		!!(/[[:lower:]]/ =~ c)
	end

	def ExtractCharset.is_upper_case?(c)
		!!(/[[:upper:]]/ =~ c)
	end

	def ExtractCharset.classify(chars_set)
		lowers = ""
		uppers = ""
		digits = ""
		the_rest = ""
		
		chars_set.each do |c|
			case 
			when is_digit?(c)
				digits << c		
			when is_lower_case?(c)
				lowers << c
			when is_upper_case?(c)
				uppers << c
			else
				the_rest << c
			end
		end

		{:lowers => lowers.chars.sort.join, 
		 :uppers => uppers.chars.sort.join, 
		 :digits => digits.chars.sort.join, 
		 :the_rest => the_rest.chars.sort.join, 
		 :glyph_count => [lowers.length, uppers.length, digits.length, the_rest.length].inject(:+)
		}
	end

	# public
	def ExtractCharset.extract(str)

		chars_set = Set.new

    str.gsub(/\r\n/m, "\n").gsub("\n", "").each_char do |char|
    	chars_set.add(char) unless is_whitespace?(char)
    end
    
    ExtractCharset::classify(chars_set)

	end

end



