class InvoiceMailer < ApplicationMailer
  def seller_invoice(invoice)
    @invoice = invoice

    attachments["invoice_#{@invoice.invoice_number}.pdf"] = InvoicePdf.new(@invoice).render

    mail(
      to: @invoice.seller.email,
      subject: "Invoice ##{@invoice.invoice_number} for Order ##{@invoice.order_id}"
    )
  end
end
