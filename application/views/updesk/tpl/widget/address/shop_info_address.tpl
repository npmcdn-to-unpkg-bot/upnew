  <div class="checkout-section">
             <h3 class="section-heading">[{$oxcmp_shop->oxshops__oxcompany->value}]</h3>
            [{$oxcmp_shop->oxshops__oxstreet->value}]</br>
            [{$oxcmp_shop->oxshops__oxzip->value}]&nbsp;[{$oxcmp_shop->oxshops__oxcity->value}]</br>
            [{$oxcmp_shop->oxshops__oxcountry->value}]</br>
            [{if $oxcmp_shop->oxshops__oxtelefon->value}]
                [{oxmultilang ident="PHONE"}] [{$oxcmp_shop->oxshops__oxtelefon->value}]</br>
            [{/if}]
            [{if $oxcmp_shop->oxshops__oxtelefax->value}]
                [{oxmultilang ident="FAX"}] [{$oxcmp_shop->oxshops__oxtelefax->value}]</br>
            [{/if}]
            [{if $oxcmp_shop->oxshops__oxinfoemail->value}]
                [{oxmultilang ident="EMAIL"}] [{oxmailto address=$oxcmp_shop->oxshops__oxinfoemail->value encode="javascript"}]</br>
            [{/if}]
</div>