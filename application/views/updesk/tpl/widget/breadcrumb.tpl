[{strip}]
<ul id="breadCrumb">
    <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
        <a href="[{$oViewConf->getHomeLink()}]" itemprop="url">
            <meta itemprop="title" content="urbanpeople.com" />
            <span class="glyphicon glyphicon-home"></span> <span class="homelink">[{oxmultilang ident="HEADER_BREADCRUMB_HOME"}]</span>
        </a>
    </li>
    [{foreach from=$oView->getBreadCrumb() item="sCrum" name="breadcrumb"}]
        <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb" [{if $smarty.foreach.breadcrumb.last}]class="active"[{/if}]>
             &nbsp;<span class="glyphicon glyphicon-menu-right"></span>&nbsp;
            <a href="[{if $sCrum.link}][{$sCrum.link}][{else}]#[{/if}]" title="[{$sCrum.title|escape:'html'}]" itemprop="url">
                <span itemprop="title">[{$sCrum.title}]</span>
            </a>
        </li>
    [{/foreach}]
</ul>
[{if 0}]
<div class="row bt3-test">
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
    <div class="col-xs-1">1</div>
</div>
<div class="row bt3-test">
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-2"><div>2</div></div>
    
</div>
<div class="row bt3-test">
    <div>nested aligned</div>
    <div class="col-xs-2">
        2
       
    </div>
    <div class="col-xs-10">
        10
        <div class="row">
           
            <div class="col-xs-2"><div>2</div></div>
            <div class="col-xs-2"><div>2</div></div>
            <div class="col-xs-2"><div>2</div></div>
            <div class="col-xs-2"><div>2</div></div>
            <div class="col-xs-2"><div>2</div></div>
        </div>
    </div>
</div>

<div class="row bt3-test">
    <div class="col-xs-4"><div>4</div></div>
    <div class="col-xs-4"><div>4</div></div>
    <div class="col-xs-4"><div>4</div></div>
</div>
<div class="row bt3-test">
    <div class="col-xs-6"><div>6</div></div>
    <div class="col-xs-6"><div>6</div></div>
</div>

<div class="row bt3-test">
    <div class="col-xs-2"><div>2</div></div>
    <div class="col-xs-10"><div>10</div></div>
</div>


<div class="row bt3-test">
    <div>nested aligned</div>
    <div class="col-xs-2">
        2
        <div class="row">
            <div class="col-xs-6"><div>6</div></div>
            <div class="col-xs-6"><div>6</div></div>
        </div>
    </div>
    <div class="col-xs-10">
        10
        <div class="row">
            <div class="col-xs-6"><div>6</div></div>
            <div class="col-xs-6"><div>6</div></div>
        </div>
    </div>
</div>

<div class="row bt3-test">
    <div>nested aligned</div>
    <div class="col-xs-2">
        2
        <div class="row">
            <div class="col-xs-6"><div>6</div></div>
            <div class="col-xs-6"><div>6</div></div>
        </div>
    </div>
    <div class="col-xs-10">
        10
        <div class="row">
            <div class="col-xs-3"><div>3</div></div>
            <div class="col-xs-3"><div>3</div></div>
            <div class="col-xs-3"><div>3</div></div>
            <div class="col-xs-3"><div>3</div></div>
        </div>
    </div>
</div>
<div class="row bt3-test">
    <div>nested aligned</div>
    <div class="col-xs-2">
        2
        <div class="row">
            <div class="col-xs-12"><div>6</div></div>
        </div>
    </div>
    <div class="col-xs-10">
        10
        <div class="row">
            <div class="col-xs-2"><div>3</div></div>
            <div class="col-xs-2"><div>3</div></div>
            <div class="col-xs-2"><div>3</div></div>
            <div class="col-xs-2"><div>3</div></div>
            <div class="col-xs-2"><div>3</div></div>
            <div class="col-xs-2"><div>3</div></div>
        </div>
    </div>
</div>


<div class="row bt3-test">
    <div>nested free</div>
    <div class="col-xs-2">
        2
        <div class="row">
            <div class="col-xs-6"><div>6</div></div>
            <div class="col-xs-6"><div>6</div></div>
        </div>
    </div>
    <div class="col-xs-10">
        10
        <div class="row">
            <div class="col-xs-4"><div>4</div></div>
            <div class="col-xs-4"><div>4</div></div>
            <div class="col-xs-4"><div>4</div></div>
        </div>
    </div>
</div>

<div class="row bt3-test">
    
    <div class="col-xs-3">
        3
        <div class="row">
            <div class="col-xs-8">1</div>
            <div class="col-xs-4">1</div>
           
        </div>
    </div>
    
    <div class="col-xs-9">
        9
        
        <div class="row">
            <div class="col-xs-4"><div>1/3</div></div>
            <div class="col-xs-4"><div>1/3</div></div>
            <div class="col-xs-4"><div>1/3</div></div>
        </div>
    </div>
</div>
[{/if}]
[{/strip}]
