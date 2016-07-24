[{capture append="oxidBlock_content"}]
    [{assign var="template_title" value=""}]

    <div class="content">
        [{* ordering steps *}]
        [{include file="page/checkout/inc/steps.tpl" active=1 }]
        
        

        [{block name="checkout_user_main"}]
            [{if !$oxcmp_user && !$oView->getLoginOption() }]
                [{include file="page/checkout/inc/options.tpl"}]
            [{/if}]

            [{block name="checkout_user_noregistration"}]
                [{if !$oxcmp_user && $oView->getLoginOption() == 1}]
                     [{capture assign="panel_user_noreg"}][{include file="form/user_checkout_noregistration.tpl"}][{/capture}]
                     [{$panel_user_noreg  }]
                [{/if}]
            [{/block}]

            [{block name="checkout_user_registration"}]
                [{if !$oxcmp_user && $oView->getLoginOption() == 3}]
                    [{capture assign="panel_user_reg"}][{include file="form/user_checkout_registration.tpl"}][{/capture}]
                     [{$panel_user_reg  }]
                [{/if}]
            [{/block}]

            [{block name="checkout_user_change"}]
                [{if $oxcmp_user}]
                    [{include file="form/user_checkout_change.tpl"}]
                [{/if}]
            [{/block}]
        [{/block}]
    </div>

    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page-checkout.tpl"}]