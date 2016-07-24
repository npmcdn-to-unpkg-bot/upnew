[{*<div class="radio inline">
    <input id="mr_[{$name}]" name="[{$name}]"[{if $value|lower  == "mr"  or $value2|lower == "mr"}] CHECKED[{/if}] type="radio" value="MR" checked/>
    <label class="glyphicon glyphicon-ok" for="mr_[{$name}]"></label>
</div>
<label for="mr_[{$name}]">[{oxmultilang ident="MR"}]</label>
<div class="radio inline">
    <input id="mrs_[{$name}]" name="[{$name}]"[{if $value|lower  == "mrs"  or $value2|lower == "mrs"}] CHECKED[{/if}] type="radio" value="MRS"/>
    <label class="glyphicon glyphicon-ok" for="mrs_[{$name}]"></label>
</div>
<label for="mrs_[{$name}]">[{oxmultilang ident="MRS"}]</label>
*}]
<label>[{oxmultilang ident="TITLE"}]</label><br>
<label class="radio-inline">
  <input type="radio"  id="mr_[{$name}]" name="[{$name}]" value="MR" [{if $value|lower  == "mr"  or $value2|lower == "mr"}] CHECKED[{/if}] checked> [{oxmultilang ident="MR"}]
</label>
<label class="checkbox-inline">
  <input type="radio"  id="mrs_[{$name}]" name="[{$name}]" value="MRS" [{if $value|lower  == "mrs"  or $value2|lower == "mrs"}] CHECKED[{/if}]> [{oxmultilang ident="MRS"}]
</label>
