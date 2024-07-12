module TaxHelper
  def calculate_taxes(cart_items, province)
    subtotal = cart_items.sum { |item| item['quantity'].to_i * item['price'].to_f }
    gst = subtotal * (province.gst / 100.0)
    pst = subtotal * (province.pst / 100.0)
    hst = subtotal * (province.hst / 100.0)
    qst = subtotal * (province.qst / 100.0)
    total_taxes = gst + pst + hst + qst
    total_amount = subtotal + total_taxes
    {
      subtotal: subtotal.round(2),
      gst: gst.round(2),
      pst: pst.round(2),
      hst: hst.round(2),
      qst: qst.round(2),
      total_taxes: total_taxes.round(2),
      total_amount: total_amount.round(2)
    }
  end
end
