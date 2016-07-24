<form action="https://www.urbanpeople.com/newsletter-phplist/" method="get">
  <div class="row">
    <div class="col-lg-2">[{* o Herren o Frauen *}]</div>
     [{ $oViewConf->getHiddenSid() }]
    
   <input type="hidden" name="p" value="subscribe">
   <input type="hidden" name="id" value="3">
   
    [{* <label>[{ oxmultilang ident="NEWSLETTER" }]</label>*}]
    <div class="col-lg-10">
        <div class="newsletter-footer">
        <input class="mailbox" type="text" name="email" placeholder="E-Mail" value="">
        <button class="mailbox submitButton" type="submit">[{ oxmultilang ident="SUBSCRIBE" }]</button>
        </div>
    </div>
  </div>
</form>