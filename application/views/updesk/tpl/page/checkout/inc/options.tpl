[{block name="checkout_user_options"}]
    <div class="checkout-options">
        
        
          [{capture assign="block_checkout_options_login"}]
            [{block name="checkout_options_login"}]
                <div id="optionLogin" class="checkout-option">
                    <p>[{oxmultilang ident="CHECKOUT_USER_ALREADY_CUSTOMER_INFO"}]</p>
                    [{include file="form/login.tpl"}]
                    
                   [{oxscript add="$( '.js-forgotpwd-link' ).click(function(e){ $( '.forgotpwd-container' ).slideToggle(); });"}] 
                    <div class="forgotpwd-container [{if $Errors}]show[{/if}]">
                     
                    <form class="js-oxValidate" action="[{$oViewConf->getSelfActionLink()}]" name="forgotpwd"  method="post">
                      [{$oViewConf->getHiddenSid()}]
                      [{$oViewConf->getNavFormParams()}]
                      <input type="hidden" name="fnc" value="forgotpassword">
                      <input type="hidden" name="cl" value="forgotpwd">
                      <input type="hidden" name="actcontrol" value="forgotpwd">
                      <input type="hidden" name="targetredirect" value="user">
                            <label>[{oxmultilang ident="YOUR_EMAIL_ADDRESS"}]</label>
                           [{* <input id="forgotPasswordUserLoginName[{$idPrefix}]" type="email" name="lgn_usr" value="[{$oView->getActiveUsername()}]" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]" > *}]
                            [{up_html_input ident="EMAIL" id="loginUser" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr" value=$smarty.post.lgn_usr }]

                            <p class="validation-error">
                                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                                <span class="js-oxError_email">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOVALIDEMAIL"}]</span>
                                [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxusername}]
                            </p>
                            <input class="btn" type="submit" value="[{oxmultilang ident="REQUEST_PASSWORD"}]"/>
                       
                    </form>
                    <p>[{oxmultilang ident="REQUEST_PASSWORD_AFTERCLICK"}]</p>
                    </div>
                </div>
            [{/block}]
        [{/capture}]
       
        [{capture assign="block_checkout_options_reg"}]
            [{block name="checkout_options_reg"}]
                <div id="optionRegistration" class="checkout-option">
                    <form class="form" action="[{$oViewConf->getOrderLink()}]" method="post">
                        <div>
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="fnc" value="" />
                            <input type="hidden" name="option" value="3" />
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <p>[{oxmultilang ident="CHECKOUT_USER_NEW_CUSTOMER_INFO"}]</p>
                            </div>
                            <div class="col-lg-12">
                                [{up_html_btn ident="OPEN_ACCOUNT" id="def" class="btn-checkout-guide multiplesmall pxwth pull-right" }]
                            </div>
                        </div>
                    </form>
                </div>
            [{/block}]
        [{/capture}]
        
        
      

      

        [{capture assign="block_checkout_options_noreg"}]
            [{block name="checkout_options_noreg"}]
                [{if $oView->getShowNoRegOption() }]
                    <div id="optionNoRegistration" class="checkout-option">
                        <form class="form" action="[{$oViewConf->getOrderLink()}]" method="post">
                            <div>
                                [{$oViewConf->getHiddenSid()}]
                                [{$oViewConf->getNavFormParams()}]
                                <input type="hidden" name="fnc" value="" />
                                <input type="hidden" name="option" value="1" />
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <p>[{oxmultilang ident="CHECKOUT_USER_GUEST_INFO"}]</p>
                                </div>
                                <div class="col-lg-12">
                                    [{up_html_btn ident="PURCHASE_WITHOUT_REGISTRATION" id="def" class="btn-checkout-guide multiplesmall pxwth pull-right" }]
                               </div>
                            </div>
                        </form>
                    </div>
                [{/if}]
            [{/block}]
        [{/capture}]
        
        
        
         <div class="row">
            <div class="col-lg-6">
                [{up_html_panel panel_title="CHECKOUT_USER_ALREADY_CUSTOMER" panel_content=$block_checkout_options_login  }]
            </div>
            <div class="col-lg-6">
                [{up_html_panel panel_title="CHECKOUT_USER_NEW_CUSTOMER" panel_content=$block_checkout_options_reg  }]
                [{up_html_panel panel_title="CHECKOUT_USER_GUEST" panel_content=$block_checkout_options_noreg  }]
            </div>
        </div>
    </div>
[{/block}]
