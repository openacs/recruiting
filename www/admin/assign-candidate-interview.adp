<master src="recruiting-admin-master">

<property name="context_bar">@context_bar@</property>

<if @searching_p@ eq 1>
    <formtemplate id="assign_interview"></formtemplate>
</if>
<else>
    <%= [ui::table::output_table search_results] %>
</else>


