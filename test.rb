module Test

	def pipo
		42
	end

	def Test.test
		puts self.pipo
	end
	
end

Test::test