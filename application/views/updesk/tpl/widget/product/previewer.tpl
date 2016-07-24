[{assign var="oDetailsProduct" value=$oView->getProduct()}]
[{assign var="oPictureProduct" value=$oView->getPicturesProduct()}]
[{assign var="currency" value=$oView->getActCurrency()}]

<div class="js-close-preview close-preview-x bl bl-x"></div>


<div class="tophead  controls-preview-head">
    <i class="glyphicon glyphicon-menu-left"></i>
    <span class="th-back js-close-preview">Zurück</span>
</div>
<div class="controls-preview">
        <div class="next-preview"><span class="glyphicon glyphicon-triangle-right"></span><span class="glyphicon glyphicon-chevron-right"></span></div>
        <div class="prev-preview"><span class="glyphicon glyphicon-triangle-left"></span><span class="glyphicon glyphicon-chevron-left"></span></div>
</div>

<div class="articlepreviewer">
    <!--dynamic part-->
    <div class="row">
    [{include file="page/details/inc/previewer_productmain.tpl"}]
   </div>
    <div class="todetails-position">
        <a class="todetails" href="[{$oDetailsProduct->getMainLink()}]">zur Produkt-Ansicht</a>
    </div>
    <!-- dynamic part -->
</div>


[{oxscript widget=$oView->getClassName()}]

