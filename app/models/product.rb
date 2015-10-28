class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	validates :name, presence: true

	validates :product_type, presence: true
	validates :units, presence: true
	validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0.00}
	validates :purchase_price, presence: true, numericality: { greater_than_or_equal_to: 0.00}
	validates :shop_price, presence: true, numericality: { greater_than_or_equal_to: 0.00}


	def total_price
		self.purchase_price * self.quantity
	end



	def remove_from_stock!(qty)
		self.quantity = self.quantity - qty
		save
	end

	def total_sold
		Array(self.line_items).sum do |item|
			item.quantity
		end
	end

	def self.to_csv
		attributes = %w{id name product_type units quantity purchase_price shop_price mass_unit_check created_at updated_at }
		CSV.generate(headers: true) do |csv| 
			csv << attributes

			all.each do |product|
				csv << product.attributes.values_at(*attributes)
			end
		end
	end

	def self.import(file)
		attributes = %w{id name product_type units quantity purchase_price shop_price mass_unit_check created_at updated_at }
		CSV.foreach(file.path, headers: true) do |row| 
			product = find_by_id(row["id"]) || new 
			product.attributes = row.to_hash.slice(*attributes)
			product.save!
		end
	end

	private

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base,'Line Items present')
			return false
		end
	end



end
