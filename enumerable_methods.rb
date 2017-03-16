module Enumerable
	def my_each
		if self.instance_of? Array
			self.length.times do |index|
				yield(self[index])
			end
		else
			hash_keys = self.keys
			hash_keys.length.times do |index|
				yield(hash_keys[index], self[hash_keys[index]])
			end
		end
		self
	end

	def each_with_index
		if self.instance_of? Array
			self.length.times do |index|
				yield(self[index], index)
			end
		end
		self
	end

	def my_select
		if self.instance_of? Array
			result = Array.new
			self.my_each do |element|
				if yield(element)
					result << element
				end
			end
		else
			result = Hash.new
			self.my_each do |key, value|
				if yield(key, value)
					result[key] = value 
				end
			end
		end
		result
	end
end