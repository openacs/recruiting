<master>

<property name="context_bar">@context_bar@</property>

<a href="new-status-type">Add new status type</a>

<p>

<b>Candidate status types:</b><br>

<table>
<if @enabled_status_types:rowcount@ gt 0>
  <multiple name="enabled_status_types">
       <tr><td>@enabled_status_types.short_desc@</td><td>(<a href="@enabled_status_types.disable_url@">disable</a>)</td></tr>
  </multiple>
</if>
<else>
   <tr><td>none defined (<a href=new-status-type.tcl>add one</a>)</td></tr>
</else>
</table>


<p>

<if @disabled_status_types:rowcount@ gt 0>
  <b>Disabled status types:</b>
  <table>
  <multiple name="disabled_status_types">
     <tr><td><font color=grey>@disabled_status_types.short_desc@</td><td>(<a href="@disabled_status_types.enable_url@">enable</a>)</tr>
  </multiple>
  </table>
</if>
