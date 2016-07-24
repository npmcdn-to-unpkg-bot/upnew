[{oxscript include="js/widgets/oxflyoutbox.js" priority=10 }]
[{oxscript add="$( '#flyoutBoxOpener' ).oxFlyOutBox();" }]
[{assign var="bIsError" value=0 }]
[{capture name=loginErrors}]
    [{foreach from=$Errors.loginBoxErrors item=oEr key=key }]
      [{oxscript add="  $('div.flyoutBox').show();" }]
        <p id="errorBadLogin" class="errorMsg">[{ $oEr->getOxMessage()}]</p>
        [{assign var="bIsError" value=1 }]
    [{/foreach}]
[{/capture}]

[{if !$oxcmp_user->oxuser__oxpassword->value}]
    <form id="login" name="login" action="[{ $oViewConf->getSslSelfLink() }]" method="post">
        <div id="loginBox" class="loginBox" [{if $bIsError}]style="display: block;"[{/if}]>
            [{ $oViewConf->getHiddenSid() }]
            [{ $oViewConf->getNavFormParams() }]
            <input type="hidden" name="fnc" value="login_noredirect">
            <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]">
            [{if $oViewConf->getTopActiveClassName() eq "content"}]
                <input type="hidden" name="oxcid" value="[{ $oViewConf->getContentId() }]">
            [{/if}]
            <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]">
            <input type="hidden" name="CustomError" value="loginBoxErrors">
            [{if $oViewConf->getActArticleId()}]
                <input type="hidden" name="anid" value="[{ $oViewConf->getActArticleId() }]">
            [{/if}]
            <div class="loginForm corners">
               [{* <h4>[{ oxmultilang ident="LOGIN" }]</h4> *}]
                 <div class="form-group  "><label for="">[{ oxmultilang ident="EMAIL_ADDRESS" }]</label><input name="lgn_usr" type="text" class="form-control " value="" placeholder="[{ oxmultilang ident="EMAIL_ADDRESS" }]"> </div>
                [{*<p>
                    [{oxscript include="js/widgets/oxinnerlabel.js" priority=10 }]
                    [{oxscript add="$( '#loginEmail' ).oxInnerLabel();"}]
                    
                    <label for="loginEmail" class="innerLabel">[{ oxmultilang ident="EMAIL_ADDRESS" }]</label>
                    <input id="loginEmail" type="text" name="lgn_usr" value="" class="textbox">
                </p>*}]
                
                 <div class="form-group  "><label for="">[{ oxmultilang ident="PASSWORD" }]</label><input name="lgn_pwd" type="password" class="form-control " value="" placeholder="[{ oxmultilang ident="PASSWORD" }]"> </div>
                [{*<p>
                    [{oxscript add="$( '#loginPasword' ).oxInnerLabel();"}]
                    <label for="loginPasword" class="innerLabel">[{ oxmultilang ident="PASSWORD" }]</label>
                    <input id="loginPasword" type="password" name="lgn_pwd" class="textbox passwordbox" value=""><strong><a class="forgotPasswordOpener" href="#" title="[{ oxmultilang ident="FORGOT_PASSWORD" }]">?</a></strong>
                </p>*}]
                
                [{$smarty.capture.loginErrors}]
                [{if $oViewConf->isFunctionalityEnabled( "blShowRememberMe" )}]
                [{*<p class="checkFields clear">
                    <input type="checkbox" class="checkbox" value="1" name="lgn_cook" id="remember"><label for="remember">[{ oxmultilang ident="REMEMBER_ME" }]</label>
                </p>*}]
                [{/if}]
                <p><a id="forgotPasswordLink" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=forgotpwd"}]" class="textLink" rel="nofollow">[{oxmultilang ident="FORGOT_PASSWORD"}]</a></p>
                <p>
                    <button type="submit" class="btn btn-checkout-guide  btn-block">[{ oxmultilang ident="LOGIN" }]</button>
                </p>
            </div>
           
        </div>
    </form>
[{else}]
[{*
    [{ oxmultilang ident="GREETING" }]
    [{assign var="fullname" value=$oxcmp_user->oxuser__oxfname->value|cat:" "|cat:$oxcmp_user->oxuser__oxlname->value }]
   
    <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account"}]">
    [{if $fullname}]
        [{$fullname }]
       
    [{else}]
        [{ $oxcmp_user->oxuser__oxusername->value|oxtruncate:25:"...":true }]
       
    [{/if}]
     
    </a>
     *}]
     
      
     <div style="text-align:center;margin-bottom:15px;">[{ $oxcmp_user->oxuser__oxusername->value|oxtruncate:25:"...":true }]</div>
    <a id="logoutLink" class="btn btn-checkout-guide  btn-block" href="[{ $oViewConf->getLogoutLink() }]" title="[{ oxmultilang ident="LOGOUT" }]">[{ oxmultilang ident="LOGOUT" }]</a>

[{/if}]
