<?xml version="1.0"?>
<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

   <fullquery name="get_should_hire_p">
       <querytext>
           select (CASE
                      WHEN (select should_hire_p 
                              from recruiting_interviews i
                             where i.interview_id = :interview_id) = 't'
                      THEN 'Yes'
                      WHEN (select should_hire_p 
                              from recruiting_interviews i
                             where i.interview_id = :interview_id) = 'f'
                      THEN 'No'
                   END) as should_hire_p
       </querytext>
   </fullquery>


</queryset>
