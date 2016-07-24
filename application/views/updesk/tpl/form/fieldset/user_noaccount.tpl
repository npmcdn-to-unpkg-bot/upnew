     <div class="form-group [{if $aErrors.oxuser__oxusername}] invalid-field[{/if}]">
        [{block name="user_noaccount_email"}]
        <label>[{oxmultilang ident="EMAIL_ADDRESS"}]*</label>
         <input id="userLoginName" class="form-control js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr" value="[{$oView->getActiveUsername()}]" size="37" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]" />
        <p class="validation-error">
                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                <span class="js-oxError_email">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOVALIDEMAIL"}]</span>
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxusername}]
        </p>
        [{/block}]
    </div>
     
    [{block name="user_noaccount_newsletter"}]
    [{/block}]
   
    