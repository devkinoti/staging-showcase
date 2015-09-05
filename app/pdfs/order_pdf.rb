require 'prawn/table'
class OrderPdf < Prawn::Document
	def initialize(order,view,current_user,page_size: [200,300])
		super(top_margin: 40)
		@order = order
		@view = view
		@current_user = current_user
		title
		order_number
		line_items
		total_price
		thanks
	end

	def title
		text "Superior Base Services LTD",size: 30,style: :bold
		move_down 10
		text "P.O Box 18512-00100"
		text "Nairobi"
		text "+254775456876"
	end

	def thanks
		move_down 20
		text "Striving to serve you better"
	end

	def order_number
		move_down 20
		text "Order \##{@order.id}",size: 15,style: :italic
	end

	def line_items
		move_down 20
		table line_item_rows, width: 400 do |table|
			table.row(0).font_style = :bold
			table.columns(1..3).align = :right
			table.row_colors = ["BCED91","FFFFFF"]
			table.header = true
		end
	end

	def line_item_rows
		[["Product","Quantity","Shop price","Total Price"]] + 
		@order.line_items.map do |item|
			[item.product.name,item.quantity,price(item.product.shop_price),price(item.total_price)]
		end
	end

	def total_price
		move_down 30
		text "Please pay this amount",size: 16
		move_down 10
		text "Total Order Price: #{price(@order.order_price)}",size: 14,style: :bold
		move_down 20
		text "Served by #{@current_user.first_name} #{@current_user.last_name}"
		move_down 10
		text "#{@order.created_at.strftime("%d-%b-%Y %H:%M")} "
	end

	def price(num)
		@view.number_to_currency(num,:precision => 0, :unit => "Ksh",:format => "%u %n")
	end
end