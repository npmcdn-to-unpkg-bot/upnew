[{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
    [{oxscript include="js/libs/modernizr.custom.min.js" priority=10}]
[{oxscript include="js/widgets/oxplaceholderfallback.js" priority=10 }]
[{oxscript add="$('form').oxPlaceholderFallback();"}]
  <form class="js-oxValidate" action="[{$oViewConf->getSelfActionLink()}]" name="forgotpwd" method="post">
                      [{$oViewConf->getHiddenSid()}]
                      [{$oViewConf->getNavFormParams()}]
                      <input type="hidden" name="fnc" value="forgotpassword">
                      <input type="hidden" name="cl" value="forgotpwd">
                      <input type="hidden" name="actcontrol" value="forgotpwd">
                            <label>[{oxmultilang ident="YOUR_EMAIL_ADDRESS"}]</label>
                           [{* <input id="forgotPasswordUserLoginName[{$idPrefix}]" type="email" name="lgn_usr" value="[{$oView->getActiveUsername()}]" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]" > *}]
                            [{up_html_input ident="EMAIL" id="loginUser" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr"  }]

                            <p class="validation-error">
                                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                                <span class="js-oxError_email">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOVALIDEMAIL"}]</span>
                                [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxusername}]
                            </p>
                        
                            <input class="btn" type="submit" value="[{oxmultilang ident="REQUEST_PASSWORD"}]"/>
                       
    </form>
                      <p>[{oxmultilang ident="REQUEST_PASSWORD_AFTERCLICK"}]</p>

  
