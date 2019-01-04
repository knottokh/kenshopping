Deface::Override.new(
  virtual_path: 'spree/shared/_error_messages2',
  name: '_error_messages overide',
  replace: "#errorExplanation",
  text: %q{
        <div id="errorExplanation" class="alert alert-danger alert-auto-disappear" data-hook>
            <h3><%= Spree.t(:errors_prohibited_this_record_from_being_saved, count: target.errors.count) %>:</h3>
            <p><%= Spree.t(:there_were_problems_with_the_following_fields) %>:</p>
             <ul>
               <% target.errors.full_messages.each do |msg| %>
                 <li><%= msg %></li>
               <% end %>
             </ul>
             <br/>
          </div>
  }
)