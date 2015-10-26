namespace :csv_export do 
	desc "creates csv export of products table"
	task :products => :environment do 
		csv_products = Product.all.order("created_at DESC")
		save_path = Rails.root.join('public','csv',"products.csv")
		File.open(save_path, 'wb') do |file|
			file.write(csv_products.to_csv)
		end
		puts "debug"
	end

	desc "creates csv export of line_items_table"
	task :line_item do 
	end

	desc "creates csv export of orders table"
	task :orders do 
	end

	desc "send csv to home application rails" 
	task :mail do 
	end

	task :all => [:products,:line_items,:orders]
end
