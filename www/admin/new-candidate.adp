<SCRIPT LANGUAGE="JavaScript">
function openPage(theImage, theWidth, theHeight) { 
   OpenWindow=window.open(theImage, "newwin", config='toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no, width='+theWidth+', height='+theHeight);
}
</SCRIPT>

<master src="recruiting-admin-master">
<property name="context_bar">@context_bar@</property>

<if @status_type_count@ ne 0>
    <formtemplate id="new_candidate"></formtemplate>
</if>
<else>
    There are no candidate status types defined.  You must <a href=new-status-type>define a status type</a> before creating candidates.
</else>


