

[{* include file="widget/locator/attributes.tpl" *}]



[{if $sort }]
<div class="controlmid clearfix">
    [{include file="widget/locator/sort.tpl"}]
    </div>
[{/if}]
<div class="controlbottom">
 [{include file="widget/locator/paging.tpl" pages=$locator place=$place}]
</div>

