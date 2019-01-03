Deface::Override.new(
  virtual_path: 'spree/shared/_base_mailer_header',
  name: '_base_mailer_header overide',
  replace: "table.header",
  text: %q{
    <table class="row header">
          <tr>
            <td class="center" align="center">
              <center>
        
                <table class="container">
                  <tr>
                    <td class="wrapper last">
        
                      <table class="twelve columns">
                        <tr>
                          <td class="twelve sub-columns last">
                          </td>
                          <td class="expander"></td>
                        </tr>
                      </table>
        
                    </td>
                  </tr>
                </table>
        
              </center>
            </td>
          </tr>
        </table>
  }
)