<master src="recruiting-admin-master">
<property name="context_bar">@context_bar@</property>

<table width=100%>
<tr><td valign=top>
<%= [ui::table::output_table ratings] %>
<p>
<%= [ui::table::output_table comments] %>
</td><td valign=top>
<%= [ui::table::output_table summary] %>
</td></tr>
</table>


