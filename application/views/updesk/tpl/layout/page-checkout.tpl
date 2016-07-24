[{capture append="oxidBlock_pageBody"}]
<div id="viewport">

    <div class="canvas-checkout">
        <div id="page">
            <div class="container">
               <div class="row">
                    <div class="col-lg-8">
                    [{ include file="layout/header-checkout.tpl" location="checkout" }]
              
                    [{include file="message/errors.tpl"}]
                    
                    [{foreach from=$oxidBlock_content item="_block"}][{$_block}][{/foreach}]
                    </div>
                    <div class="col-lg-4 resp-xs-togglecart resp-lg-togglecart">
                       [{include file="layout/sidebar-checkout.tpl"}]
                    </div>
                </div>
            </div>
        </div>
        [{ include file="layout/footer-checkout.tpl" }]
    </div>
</div>
[{/capture}]
[{include file="layout/base.tpl"}]