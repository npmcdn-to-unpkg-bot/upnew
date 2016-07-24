[{oxscript include="js/widgets/oxinputvalidator.js" priority=10}]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
[{oxscript include="js/libs/modernizr.custom.min.js" priority=10}]
[{oxscript include="js/widgets/oxplaceholderfallback.js" priority=10 }]
[{oxscript add="$('form').oxPlaceholderFallback();"}]
<form name="login" class="js-oxValidate form-group" action="[{$oViewConf->getSslSelfLink()}]" method="post">
    <div>
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="fnc" value="login_noredirect">
        <input type="hidden" name="cl" value="[{if $oViewConf->getActiveClassName() != 'login'}][{$oViewConf->getActiveClassName()}][{/if}]"> 
        <input type="hidden" name="tpl" value="[{$oViewConf->getActTplName()}]">
        <input type="hidden" name="oxloadid" value="[{$oViewConf->getActContentLoadId()}]">
        [{if $oView->getArticleId()}]
          <input type="hidden" name="aid" value="[{$oView->getArticleId()}]">
        [{/if}]
        [{if $oView->getProduct()}]
          [{assign var="product" value=$oView->getProduct() }]
          <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
        [{/if}]
    </div>


    [{up_html_input ident="EMAIL" id="loginUser" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" value=$smarty.post.lgn_usr  name="lgn_usr"  }]


    [{up_html_input ident="PASSWORD" id="loginPwd" class="js-oxValidate js-oxValidate_notEmpty" type="password" name="lgn_pwd"  }]


    
        [{if $oView->showRememberMe() && 1==2}] [{* mit hidden feld fix setzen *}]
     
            <div class="checkbox">
                <input id="loginCookie" type="checkbox" name="lgn_cook" value="1">
                <label for="loginCookie" class="glyphicon glyphicon-ok"></label>
            </div>
            <label for="loginCookie">[{oxmultilang ident="KEEP_LOGGED_IN"}]</label>
        
        [{/if}]
        [{up_html_btn ident="LOGIN" id="loginButton" class="btn-block"}]
         

        [{if 0}]
        <ul class="form"> 
            <li [{if $aErrors}]class="invalid-field"[{/if}]>
                <input placeholder="[{oxmultilang ident="EMAIL"}]*" id="loginUser" class="js-oxValidate js-oxValidate_notEmpty" type="email" name="lgn_usr" value="" size="37" >
                <p class="validation-error">
                    <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                </p>
            </li>
            <li [{if $aErrors}]class="invalid-field"[{/if}]>
                <input placeholder="[{oxmultilang ident="PASSWORD"}]*" id="loginPwd" class="js-oxValidate js-oxValidate_notEmpty textbox" type="password" name="lgn_pwd" value="" size="37">
                <p class="validation-error">
                    <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                </p>
            </li>
            [{if $oView->showRememberMe()}]
            <li>
                <div class="checkbox">
                    <input id="loginCookie" type="checkbox" name="lgn_cook" value="1">
                    <label for="loginCookie" class="glyphicon glyphicon-ok"></label>
                </div>
                <label for="loginCookie">[{oxmultilang ident="KEEP_LOGGED_IN"}]</label>
            </li>
            [{/if}]
           
            <li class="formSubmit">
                <input id="loginButton" type="submit" class="btn" value="[{oxmultilang ident="LOGIN"}]" />
            </li>

        </ul>
        [{/if}]
</form>
<div class="text-center">
<a id="forgotPasswordLink" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=forgotpwd"}]" class="textLink" rel="nofollow">[{oxmultilang ident="FORGOT_PASSWORD"}]</a>

<br />
<hr>
<a id="openAccountLink" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=register"}]" class="textLink" rel="nofollow">[{oxmultilang ident="OPEN_ACCOUNT"}]</a>

</div>