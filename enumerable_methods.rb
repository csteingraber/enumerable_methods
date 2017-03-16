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

	def my_all?
		passed = 0
		if self.instance_of? Array
			self.my_each do |element|
				if yield(element)
					passed += 1
				end
			end
		else
			self.my_each do |key, value|
				if yield(key, value)
					passed += 1 
				end
			end
		end
		if passed == self.length
			passed = true
		else
			passed = false
		end
		passed
	end

	def my_any?
		passed = 0
		if self.instance_of? Array
			self.my_each do |element|
				if yield(element)
					passed += 1
				end
			end
		else
			self.my_each do |key, value|
				if yield(key, value)
					passed += 1 
				end
			end
		end
		if passed > 0
			passed = true
		else
			passed = false
		end
		passed
	end

	def my_none?
		passed = 0
		if self.instance_of? Array
			self.my_each do |element|
				if yield(element)
					passed += 1
				end
			end
		else
			self.my_each do |key, value|
				if yield(key, value)
					passed += 1 
				end
			end
		end
		if passed == 0
			passed = true
		else
			passed = false
		end
		passed
	end	

	def my_count(element=nil)
		passed = 0 
		if element != nil
			self.my_each do |item|
				if item == element
					passed += 1
				end
			end
			return passed
		elsif block_given?
			self.my_each do |item|
				if yield(item)
					passed += 1
				end
			end
			return passed
		else
			return self.length
		end
	end

	def my_map(proc=nil)
		result = []
		if proc != nil
			self.my_each do |element|
				result << proc.call(element)
			end
		else
			self.my_each do |element|
				result << yield(element)
			end
		end
		result
	end

	def my_inject(initial=nil)
		if initial == nil
			total = self[0]
		else
			total = initial
		end
		self.my_each do |element|
			total = yield(total, element)
		end
		total
	end
end

def multiply_els(array)
	array.my_inject(1) do |total, element|
		total * element
	end
end

puts multiply_els([2, 4, 5])