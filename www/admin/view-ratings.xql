<?xml version="1.0"?>
<queryset>

   <fullquery name="get_interviewer_info">
       <querytext>
            select first_names||' '||last_name as interviewer_name,
                   email as interviewer_email
              from registered_users
             where user_id = :interviewer_id
       </querytext>
   </fullquery>

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

</queryset>
