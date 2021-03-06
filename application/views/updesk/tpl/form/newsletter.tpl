[{assign var="aRegParams" value=$oView->getRegParams()}]
[{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
<form class="js-oxValidate" action="[{$oViewConf->getSslSelfLink()}]" method="post">
    <div>
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="fnc" value="send">
        <input type="hidden" name="cl" value="newsletter">
        <input type="hidden" name="editval[oxuser__oxcountryid]" value="[{$oView->getHomeCountryId()}]">
    </div>
    
     [{include file="form/fieldset/salutation.tpl" name="editval[oxuser__oxsal]" value=$aRegParams.oxuser__oxsal}]
    [{up_html_checkout_input ident="FIRST_NAME" name="editval.oxuser__oxfname" fdat=$aRegParams.oxuser__oxfname }]
     [{up_html_checkout_input ident="LAST_NAME" name="editval.oxuser__oxlname" fdat=$aRegParams.oxuser__oxlname }]

     [{up_html_checkout_input ident="EMAIL" name="editval.oxuser__oxusername" fdat=$aRegParams }]
     
  
            <input id="newsletterSubscribeOn" class="radiobox" type="radio" name="subscribeStatus" value="1" checked><label for="newsletterSubscribeOn">[{oxmultilang ident="SUBSCRIBE"}]</label>
            <input id="newsletterSubscribeOff" class="radiobox" type="radio" name="subscribeStatus" value="0"><label for="newsletterSubscribeOff">[{oxmultilang ident="UNSUBSCRIBE"}]</label>
       
            <button id="newsLetterSubmit" class="submitButton largeButton" type="submit">[{oxmultilang ident="SUBMIT"}]</button>
    [{if 0}]
    <ul class="form">
        <li>
            <label>[{oxmultilang ident="TITLE"}]</label>
            [{include file="form/fieldset/salutation.tpl" name="editval[oxuser__oxsal]" value=$aRegParams.oxuser__oxsal}]
        </li>
        <li>
            <label>[{oxmultilang ident="FIRST_NAME"}]</label>
            <input id="newsletterFname" type="text" name="editval[oxuser__oxfname]" size=40 maxlength=40 value="[{if $aRegParams.oxuser__oxfname}][{$aRegParams.oxuser__oxfname}][{/if}]">
        </li>
        <li>
            <label>[{oxmultilang ident="LAST_NAME"}]</label>
            <input id="newsletterLname" type="text" name="editval[oxuser__oxlname]" size=40 maxlength=40 value="[{if $aRegParams.oxuser__oxlname}][{$aRegParams.oxuser__oxlname}][{/if}]">
        </li>
        <li [{if $aErrors}]class="invalid-field"[{/if}]>
            <label>[{oxmultilang ident="EMAIL"}]*</label>
            <input id="newsletterUserName" type="email" class="js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" name="editval[oxuser__oxusername]" size=40 maxlength=40 value="[{if $aRegParams.oxuser__oxusername}][{$aRegParams.oxuser__oxusername}][{/if}]">
            <p class="validation-error">
                <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                <span class="js-oxError_email">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOVALIDEMAIL"}]</span>
            </p>
        </li>
        <li class="checkFields">
            <input id="newsletterSubscribeOn" class="radiobox" type="radio" name="subscribeStatus" value="1" checked><label for="newsletterSubscribeOn">[{oxmultilang ident="SUBSCRIBE"}]</label>
            <input id="newsletterSubscribeOff" class="radiobox" type="radio" name="subscribeStatus" value="0"><label for="newsletterSubscribeOff">[{oxmultilang ident="UNSUBSCRIBE"}]</label>
        </li>
        <li class="alert alert-block">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</li>
        <li class="formSubmit">
            <button id="newsLetterSubmit" class="submitButton largeButton" type="submit">[{oxmultilang ident="SUBMIT"}]</button>
        </li>
    </ul>
    [{/if}]
</form>