namespace :pick do 
	desc "Pick first user as winner"
	task :winner => :environment do 
		puts "winner #{pick(User).first_name}"
	end

	task :prize => :environment do 
		puts "prize #{pick(Product).name}"
	end

	task :all => [:winner, :prize]

	def pick(model_class)
		model_class.first
	end
end