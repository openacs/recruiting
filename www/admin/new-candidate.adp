<master>

<if @status_type_count@ ne 0>
    <formtemplate id="new_candidate"></formtemplate>
</if>
<else>
    There are no candidate status types defined.  You must <a href=new-status-type>define a status type</a> before creating candidates.
</else>
