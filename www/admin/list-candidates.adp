<master>

<b>Candidates:</b><br>

<table>
<if @list_candidates:rowcount@ gt 0>
  <multiple name="list_candidates">
       <tr><td>@list_candidates.last_name@, @list_candidates.first_name@ from @list_candidates.city@, @list_candidates.state@ (<a href="mailto:@list_candidates.email@">send email</a>)</td><td></td></tr>
  </multiple>
</if>
<else>
   <tr><td>No candidates (<a href=new-candidate>add one</a>)</td></tr>
</else>
</table>

