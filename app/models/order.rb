class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	has_many :products, through: :line_items
    belongs_to :user

	validates_with EnoughProductsValidator
	validates :cash_paid, numericality: { greater_than_or_equal_to: 0.00, message: "Please enter the figure as a number" }
	
	after_create :calculate_stock

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end



	def calculate_stock
      self.line_items.each do |item|
        item.product.remove_from_stock!(item.quantity)
      end
    end

    def order_price
    	Array(line_items).sum do |item|
    		item.product.shop_price * item.quantity
    	end
    end

    def self.total_grouped_by_day(start)
    	orders = where(created_at: start.beginning_of_day..Time.zone.now).where(:paid => true).group("orders.id, created_at")
    	orders.group_by { |order| order.created_at.to_date }
    end

    def self.total_grouped_by_month(start)
    	orders = where(created_at: start.beginning_of_month..Time.zone.now).where(:paid => true).group("orders.id, created_at")
    	orders.group_by { |order| order.created_at.to_date.month }
    end

    def self.import(file)
        attributes = %w{id paid created_at updated_at cash_paid user_id }
        CSV.foreach(file.path,headers: true) do |row| 
            order = find_by_id(row["id"]) || new 
            order.attributes = row.to_hash.slice(*attributes)
            order.save!
        end
    end



end
