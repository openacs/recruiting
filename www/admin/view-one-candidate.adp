<master src="recruiting-admin-master">
<property name="context_bar">@context_bar@</property>

<table width=100%>
<tr><td>
<%= [table::outputTable candidate] %>
<p>
<%= [table::outputTable interviews] %>
</td><td valign=top>
<%= [table::outputTable options] %>
</td></tr>
</table>

