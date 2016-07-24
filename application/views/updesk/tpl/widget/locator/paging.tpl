[{if $pages->changePage && $place eq "bottom" }]
    <div class="pagination-container">
        <ul class="pagination" id="itemsPager[{$place}]">
            [{if $pages->previousPage }]<li><a role="button"  href="[{$pages->previousPage}]"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></a></li>[{/if}]
            [{assign var="i" value=1}]
            [{foreach key=iPage from=$pages->changePage item=page}]
                [{if $iPage == $i}]
                   <li><a href="[{$page->url}]" class="pagination-page[{if $iPage == $pages->actPage }] active[{/if}]">[{$iPage}]</a></li>
                   [{assign var="i" value=$i+1}]
                [{elseif $iPage > $i}]
                   <li>
                       <a class="pagination-separator">...</a>
                   </li>
                   <li>
                        <a href="[{$page->url}]" class="pagination-page[{if $iPage == $pages->actPage }] active[{/if}]">[{$iPage}]</a>
                   </li>
                   [{assign var="i" value=$iPage+1}]
                [{elseif $iPage < $i}]
                    <li>
                        <a href="[{$page->url}]" class="pagination-page[{if $iPage == $pages->actPage }] active[{/if}]">[{$iPage}]</a>
                    </li>
                    <li>
                        <a class="pagination-separator">...</a>
                        [{assign var="i" value=$iPage+1}]
                    </li>
                [{/if}]
            [{/foreach}]
            [{if $pages->nextPage }]<li><a role="button" href="[{$pages->nextPage}]"><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a></li>[{/if}]
         </ul>
    </div>
[{/if}]
[{*}]
<pre>
  [{$pages|print_r}]
</pre>
[{*}]
[{if $pages->changePage && $place != "bottom"}]
    <div class="tinypagination">
          [{if $pages->previousPage }]<a role="button"  href="[{$pages->previousPage}]"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></a>[{/if}]
          
          <span>[{ oxmultilang ident="PAGE" }] [{$pages->actPage}] [{ oxmultilang ident="FROM_lc" }] [{$pages->NrOfPages}]</span>
          
          [{if $pages->nextPage }]<a role="button" href="[{$pages->nextPage}]"><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a>[{/if}]
    </div>
[{/if}]