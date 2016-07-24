<div class="form-group [{if $aErrors.oxuser__oxusername}] invalid-field[{/if}]">
    [{block name="user_account_username"}]
    <label>[{oxmultilang ident="EMAIL_ADDRESS"}]*</label>
    <input id="userLoginName" class="form-control js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr" value="[{$oView->getActiveUsername()}]" size="37" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]" />
    <p class="validation-error">
            <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
            <span class="js-oxError_email">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOVALIDEMAIL"}]</span>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxusername}]
    </p>
    [{/block}]
</div>
<div class="form-group [{if $aErrors.oxuser__oxpassword}] invalid-field[{/if}]">
    [{block name="user_account_password"}]
    <label>[{oxmultilang ident="PASSWORD"}]*</label>
    <input type="hidden" id="passwordLength" value="[{$oViewConf->getPasswordLength()}]">
    <input id="userPassword" class="form-control textbox js-oxValidate js-oxValidate_notEmpty js-oxValidate_length js-oxValidate_match" type="password" name="lgn_pwd" value="[{$lgn_pwd}]" size="37" placeholder="[{oxmultilang ident="PASSWORD"}]" />
    <p class="validation-error">
            <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
            <span class="js-oxError_length">[{oxmultilang ident="ERROR_MESSAGE_PASSWORD_TOO_SHORT"}]</span>
            <span class="js-oxError_match">[{oxmultilang ident="ERROR_MESSAGE_USER_PWDDONTMATCH"}]</span>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
    </p>
    [{/block}]
</div>
<div class="form-group [{if $aErrors.oxuser__oxpassword}] invalid-field[{/if}]">
    [{block name="user_account_confirmpwd"}]
    <label>[{oxmultilang ident="CONFIRM_PASSWORD"}]*</label>
    <input id="userPasswordConfirm" class="form-control textbox js-oxValidate js-oxValidate_notEmpty js-oxValidate_length js-oxValidate_match" type="password" name="lgn_pwd2" value="[{$lgn_pwd2}]" size="37" placeholder="[{oxmultilang ident="CONFIRM_PASSWORD"}]" />
    <p class="validation-error">
            <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
            <span class="js-oxError_length">[{oxmultilang ident="ERROR_MESSAGE_PASSWORD_TOO_SHORT"}]</span>
            <span class="js-oxError_match">[{oxmultilang ident="ERROR_MESSAGE_USER_PWDDONTMATCH"}]</span>
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
    </p>
    [{/block}]
</div>
<div>
    [{block name="user_account_newsletter"}]
    [{/block}]
</div>