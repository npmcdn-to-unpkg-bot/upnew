[{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
[{oxscript include="js/libs/modernizr.custom.min.js" priority=10}]
[{oxscript include="js/widgets/oxplaceholderfallback.js" priority=10 }]
[{oxscript add="$('form').oxPlaceholderFallback();"}]
<form class="js-oxValidate" name="login" action="[{$oViewConf->getOrderLink()}]" method="post">
    [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
    <div>
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="fnc" value="login_noredirect">
    </div>
   <div>
   </div>
        <div class="userlogin-extra-margin">
            [{up_html_input ident="EMAIL_ADDRESS" id="loginUser" class="js-oxValidate js-oxValidate_notEmpty" type="email" name="lgn_usr"  value=$smarty.post.lgn_usr }]
            [{up_html_input ident="PASSWORD" id="loginPwd" class="js-oxValidate js-oxValidate_notEmpty" type="password" name="lgn_pwd"  }]
            
             <a class="ga-user-forgotpwd js-forgotpwd-link preventdefault" href="#">[{oxmultilang ident="FORGOT_PASSWORD"}]</a>
      
        </div>
        [{*<li [{if $aErrors}]class="invalid-field"[{/if}]>
            <input type="email" name="lgn_usr" class="js-oxValidate js-oxValidate_notEmpty" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]" />
            <p class="validation-error">
                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
            </p>
        </li>


        <li [{if $aErrors}]class="invalid-field"[{/if}]>
            <input type="password" name="lgn_pwd" class="js-oxValidate js-oxValidate_notEmpty" placeholder="[{oxmultilang ident="PASSWORD"}]" />
            <p class="validation-error">
                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
            </p>
        </li>*}]
        <div class="clearfix">
                [{up_html_btn ident="LOGIN" id="loginButton" class="btn-checkout-guide multiplesmall pxwth pull-right"}]
        </div>

</form>
