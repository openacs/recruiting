<?xml version="1.0"?>
<queryset>
   <fullquery name="get_interviews">
       <querytext>
           select i.interview_id,
                  p.person_id,
                  p.first_names,
                  p.last_name,
                  (select count(*) 
                     from recruiting_ratings r
                    where r.interview_id = i.interview_id) as num_ratings
             from persons p,
                  recruiting_interviews i
            where i.interviewer_id = p.person_id
              and i.candidate_id = :candidate_id
         order by last_name
       </querytext>
   </fullquery>

   <fullquery name="get_num_criteria">
       <querytext>
           select count(*) 
             from recruiting_criteria
            where enabled_p = 't'           
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

   <fullquery name="get_average_rating">
       <querytext>
             select round(avg(r.rating),1) as rating
               from recruiting_ratings r
              where r.interview_id = recruiting_interviews.interview_id
                and recruiting_interviews.interview_id = :interview_id
       </querytext>
   </fullquery>

</queryset>
