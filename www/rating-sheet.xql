<?xml version="1.0"?>
<queryset>

   <fullquery name="get_ratings">
       <querytext>
            select cr.criteria_id,
                   cr.criteria_name, cr.description,
                   r.rating
              from recruiting_criteria cr,
                   recruiting_ratings r
             where r.interview_id = :interview_id
               and r.criteria_id = cr.criteria_id
       </querytext>
   </fullquery>

   <fullquery name="get_average_rating">
       <querytext>
            select round(avg(r.rating),1)
              from recruiting_ratings r
             where r.interview_id = :interview_id
       </querytext>
   </fullquery>

   <fullquery name="get_should_hire_p">
       <querytext>
             select (CASE
                      WHEN i.should_hire_p = 't'
                      THEN 'Yes'
                      WHEN i.should_hire_p = 'f'
                      THEN 'No'
                     END) as should_hire_p                  
              from recruiting_interviews i
             where i.interview_id = :interview_id
       </querytext>
    </fullquery>
</queryset>
