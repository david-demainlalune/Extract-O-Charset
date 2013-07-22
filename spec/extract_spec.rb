
# encoding: UTF-8
require "minitest/autorun"
require_relative "../extract_charset_service/extract"

def build_expected_hash(lowers, uppers, digits, the_rest)
	{
		:lowers => lowers,
		:uppers => uppers,
		:digits => digits,
		:the_rest => the_rest,
		:glyph_count => [lowers.length, uppers.length, digits.length, the_rest.length].inject(:+)
	}
	
end

describe "Extract::extract", "test the public method extract" do

  it "should return a hash" do
    result = ExtractCharset::extract("test")
    result.must_be_instance_of Hash
  end

  it "should accept an empty string as input" do
  	expected_hash = build_expected_hash("", "", "", "")
  	result = ExtractCharset::extract("")
    result.must_equal expected_hash
	end

  it "should return unique characters set from the string" do
  	test_string = "111 aaa AAA !!!"
  	expected_hash = build_expected_hash('a', 'A', '1', '!')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

  it "should handle accented characters" do
  	# test_string = "ªŋÃÇ"
  	test_string = "\u00aa\u014b\u00c3\u00c7"
  	expected_hash = build_expected_hash("\u00aa\u014b", 
  																			"\u00c3\u00c7", 
  																			'', 
  																			'')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

  it "fails on ligatures (they are treated as one character)" do
  	# test_string = ffl ligature
  	test_string = "\ufb04"
  	expected_hash = build_expected_hash("\ufb04", 
  																			'', 
  																			'', 
  																			'')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

  it "should sort results in a semi alphabetical order" do
  	test_string = "z9a4f\u00e9ZSA"  #\u00e9 is é
  	expected_hash = build_expected_hash("afz\u00e9", 
  																			'ASZ', 
  																			'49', 
  																			'')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

  it "should return a count of all glyphs" do
  	test_string = "asdkl2092A.)"
		result = ExtractCharset::extract(test_string)
  	result[:glyph_count].must_equal 11
  end 

  it "should reject whitespaces" do
  	test_string = " _ _ _ _    _"
  	expected_hash = build_expected_hash('', 
  																			'', 
  																			'', 
  																			'_')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

  it "should reject all newline characters" do 
  	test_string = "\ntest\r\n12"
  	expected_hash = build_expected_hash('est', 
  																			'', 
  																			'12', 
  																			'')
  	result = ExtractCharset::extract(test_string)
  	result.must_equal expected_hash
  end

end