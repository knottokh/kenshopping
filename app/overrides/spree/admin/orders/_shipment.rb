Deface::Override.new(
  virtual_path: 'spree/admin/orders/_shipment',
  name: 'spree admin orders _shipment overide',
  replace: "tr.show-method td.actions",
  text: %q{
    <td class="actions text-center"> </td>
  }
)