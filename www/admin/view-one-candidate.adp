<master src="recruiting-admin-master">
<property name="context_bar">@context_bar@</property>

<table width=100%>
<tr><td>
<%= [ui::table::output_table candidate] %>
<p>
<%= [ui::table::output_table resume] %>
<p>
<%= [ui::table::output_table interviews] %>
</td><td valign=top>
<%= [ui::table::output_table options] %>
</td></tr>
</table>



