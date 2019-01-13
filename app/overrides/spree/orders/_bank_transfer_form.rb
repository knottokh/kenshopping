Deface::Override.new(
  virtual_path: 'spree/orders/_bank_transfer_form999',
  name: 'orders _bank_transfer_form overide',
  insert_before: "table",
  text: %q{
      <%= form_for bank_transfer_payment, html: { class: "bt_payment_form" } do |f| %>
      <div style="padding-bottom: 2px;">
        <%= f.file_field :bank_attachment, onchange: "validateFiles(this);",data: { max_file_size: 5.byte } %>
      </div>
      <%= f.submit "Submit", :class => "btn btn-sm btn-default bt_payment_form_submit", confirm: Spree.t(:confirm_details_submit) ,data: { disable_with: false } %>
    <% end %>
      
  }
)