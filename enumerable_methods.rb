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
end