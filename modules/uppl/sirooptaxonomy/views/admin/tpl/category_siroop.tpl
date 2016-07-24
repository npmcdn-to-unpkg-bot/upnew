<!doctype html>
<html>
  <head>
    <script src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
    <script src="//cdn.jsdelivr.net/algoliasearch/3.14.2/algoliasearch.min.js"></script>

    <link rel="stylesheet" href="//cdn.jsdelivr.net/bootstrap/3.3.4/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="[{$oViewConf->getBaseDir()}]modules/uppl/sirooptaxonomy/out/admin/src/css/style.css" />
    
  </head>
  <body>
    <form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="cl" value="category_siroop">
        <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
    </form>
    
    <div class="siroop-caturl">[{if $saved}]Saved![{else}]Kategorie Url: <a href="[{$edit->getLink()}]" target="_blank">[{$edit->getLink()}]</a>[{/if}]</div>
    <div class="siroop-taxonomy-finder" data-clicktarget=".tid-target">
        <header class="search-heading">
          <input autocomplete="off" class="siroop-taxonomy-query form-control pull-left" id="q" placeholder="Kategorie Suchbegriff" type="text" spellcheck="false" />
          <form action="[{ $oViewConf->getSelfLink() }]" method="post">
                [{$oViewConf->getHiddenSid()}]
                <input type="hidden" name="oxid" value="[{$oxid}]">
                <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                <input type="hidden" name="fnc" value="save">
                <input type="hidden" name="actshop" value="[{ $oViewConf->getActiveShopId() }]">
                <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                <input type="submit" class="btn btn-default pull-right" value="Speichern" />
                <input class="tid-target form-control pull-right" name="tid" type="text" value="[{$edit->getSiroopTid()}]" placeholder="Taxonomy Id" />
          </form>
          <div class="nbHits"></div>
          <div class="tid-preview"></div>
        </header>
       
        <section class="results">
          <div id="hits"></div>
        </section>
    </div>

    <script type="text/javascript">
      function searchCallback(err, content) {
        if (err) {
          // error
          return;
        }

        /*
        if (content.query !== $('#q').val()) {
          // do not take out-dated answers into account
          return;
        }*/

        if(content.hits.length === 0) {
          // no results
          $('#hits').empty();
          return;
        }
        
        
        $('.nbHits').html( content.nbHits + ' Results' );
        
        var html = '';
        
        //siroop taxonomy levels
        var levels = ['Level 1','Level 2','Level 3','Level 4','Level 5','Level 6', 'Level 7'];
        
        for (var i = 0; i < content.hits.length; ++i) {
          var hit = content.hits[i];
          html += '<div class="hit" data-tid="' + hit.Id + '" >';
          for (var lv = 0; lv < levels.length; ++lv) {
        
            if(hit[ levels[lv] ] ){
              
              var res;
              if( hit._highlightResult[ levels[lv] ].matchedWords.length > 0 ){
                res = hit._highlightResult[ levels[lv] ].value;
              }else{
                res =  hit[ levels[lv] ];
              }
               
              html += '<div class="attribute">';
              html +=   '<div class="res">' + res + '</div>';
              html += '</div>';
            }
          }
          html += '</div>';
        }
        
        $('#hits').html( html );
      }

      $(document).ready(function() {
        
        var APPLICATION_ID = 'SJ9E0ELB77';
        var SEARCH_ONLY_API_KEY = '238e22c360fe7296f4396f1a71931be3';
        
        var $stfWidget = $('.siroop-taxonomy-finder');
        var $inputfield = $stfWidget.find('.siroop-taxonomy-query');
        var $tid_target = $( $stfWidget.data('clicktarget') ); // tid target field 
      
        var client = algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
        var index = client.initIndex('siroop_taxonomy');
        
        //split stuff for auto matching
        var CATURL = "[{$edit->getLink()}]";
        var res = CATURL.split(".com");
        var res2 = res[1].split("/");
        
        var CATSTRING = res2.join(" ");
    
        
        if(CATSTRING){
          index.search( CATSTRING , searchCallback);
        }
        // >> auto matching
        
        $inputfield.keyup(function() {
          index.search($inputfield.val(), searchCallback);
        });
        
        $('#hits').on('mouseover', '.hit', function(e) {
          $('.tid-preview').html( '<div>Siroop Taxonomy Id: <b>'+ $(this).data('tid') + '</b></div>' );
        });
        
        $('#hits').on('click', '.hit', function(e) {
            $tid_target.val( $(this).data('tid') );
        });
        
      });
    </script>



[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
