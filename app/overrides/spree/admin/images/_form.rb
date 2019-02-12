Deface::Override.new(
  virtual_path: 'spree/admin/images/_form',
   name: 'spree admin images _form',
  replace: "[data-hook='admin_image_form_fields']",
  text: %q{
    <div data-hook="admin_image_form_fields" class="row">
      <div class="col-xs-12 col-md-6">
        <div data-hook="file" class="form-group">
          <%= f.label :attachment, Spree.t(:filename) %>
          <%= f.file_field :attachment , onchange: "validateFiles(this);" ,data: { max_file_size: 5.megabytes }%>
          <p class="image_guide"><%= Spree.t(:image_guide,imgsize: "5MB") %> </p>
        </div>
        <div data-hook="variant" class="form-group">
          <%= f.label :viewable_id, Spree::Variant.model_name.human %>
          <%= f.select :viewable_id, @variants, {}, {class: 'select2'} %>
        </div>
      </div>
      <div data-hook="alt_text" class="col-xs-12 col-md-6">
        <div class="form-group">
          <%= f.label :alt, Spree.t(:alt_text) %>
          <%= f.text_area :alt, rows: 4, class: 'form-control' %>
        </div>
      </div>
    </div>
  }
)