<master>

<a href="new-criteria">Add New Criteria</a>

<p>

<b>Interview criteria:</b>
<table>
<if @enabled_criteria_types:rowcount@ gt 0>
  <multiple name="enabled_criteria_types">
       <tr><td>@enabled_criteria_types.criteria_name@</td><td>(<a href="@enabled_criteria_types.disable_url@">disable</a>)</tr>
  </multiple>
</if>
<else>
  <tr><td>none defined (<a href=new-criteria>add one</a>)</td></tr>
</else>
</table>

<p>

<if @disabled_criteria_types:rowcount@ gt 0>
  <b>Disabled criteria:</b>
  <table>
  <multiple name="disabled_criteria_types">
     <tr><td><font color=grey>@disabled_criteria_types.criteria_name@</td><td>(<a href="@disabled_criteria_types.enable_url@">enable</a>)</tr>
  </multiple>
  </table>
</if>
