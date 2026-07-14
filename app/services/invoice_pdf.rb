class InvoicePdf
  def initialize(invoice)
    @invoice = invoice
  end

  def render
    Prawn::Document.new(margin: 40) do |pdf|
      header(pdf)
      parties(pdf)
      line_items_table(pdf)
      totals(pdf)
      footer(pdf)
    end.render
  end

  private

  def header(pdf)
    pdf.text "INVOICE", size: 18, style: :bold, align: :center
    pdf.move_down 4
    pdf.text @invoice.invoice_number, size: 10, align: :center, color: "666666"
    pdf.move_down 10
    pdf.stroke_horizontal_rule
    pdf.move_down 15
  end

  def parties(pdf)
    order = @invoice.order

    pdf.text "Invoice Date: #{@invoice.created_at.strftime('%d %b %Y')}", size: 10
    pdf.move_down 12

    pdf.text "Sold By", size: 9, style: :bold, color: "666666"
    pdf.text @invoice.seller.name, size: 11
    pdf.text @invoice.seller.email, size: 10, color: "444444"
    pdf.move_down 10

    pdf.text "Ship To", size: 9, style: :bold, color: "666666"
    pdf.text order.shipping_name.to_s, size: 11
    pdf.text order.shipping_address.to_s, size: 10, color: "444444"
    pdf.text "#{order.shipping_city}, #{order.shipping_state} - #{order.shipping_pincode}", size: 10, color: "444444"
    pdf.text "Phone: #{order.shipping_phone}", size: 10, color: "444444"
    pdf.move_down 15
  end

  def line_items_table(pdf)
    rows = [ [ "Product", "Qty", "Rate (Rs.)", "Amount (Rs.)" ] ]

    @invoice.line_items.includes(:product).each do |item|
      rows << [
        item.product.name,
        item.quantity.to_s,
        item.price.to_s,
        (item.price * item.quantity).to_s
      ]
    end

    pdf.table(rows, header: true, width: pdf.bounds.width) do |t|
      t.row(0).font_style = :bold
      t.row(0).background_color = "1B1F3B"
      t.row(0).text_color = "FFFFFF"
      t.columns(1..3).align = :right
      t.cells.padding = 8
      t.cells.borders = [ :bottom ]
      t.cells.border_color = "DDDDDD"
    end

    pdf.move_down 15
  end

  def totals(pdf)
    pdf.text "Total: Rs. #{@invoice.amount}", size: 14, style: :bold, align: :right
    pdf.move_down 20
  end

  def footer(pdf)
    pdf.stroke_horizontal_rule
    pdf.move_down 8
    pdf.text "This is a computer-generated invoice from Marketplace.", size: 8, color: "999999", align: :center
  end
end
