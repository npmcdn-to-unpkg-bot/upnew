[{if $blOrderRemark}]
    [{oxscript include="js/widgets/oxinnerlabel.js" priority=10}]
    [{oxscript add="$( '#orderRemark' ).oxInnerLabel();"}]
    
        <h3 class="section-heading">[{oxmultilang ident="WHAT_I_WANTED_TO_SAY"}]</h3>
        <textarea style="width:100%;" id="orderRemark" placeholder="[{oxmultilang ident="HERE_YOU_CAN_ENTER_MESSAGE"}]" rows="6" name="order_remark" class="areabox" >[{$oView->getOrderRemark()}]</textarea>
      [{oxscript add='$( "#orderRemark" ).on( "keyup paste", function() { $( "#cloned_order_remark" ).val( $( this ).val() ); } );' }]

[{/if}]