<?xml version="1.0"?>
<queryset>

   <fullquery name="get_ratings_by_candidate">
       <querytext>
            select cr.criteria_id,
                   cr.criteria_name,
                   round(avg(r.rating),1) as rating
              from recruiting_ratings r,
                   recruiting_criteria cr
             where cr.criteria_id = r.criteria_id
               and r.interview_id = recruiting_interviews.interview_id
               and recruiting_interviews.candidate_id = :candidate_id
          group by cr.criteria_id, cr.criteria_name
       </querytext>
   </fullquery>

   <fullquery name="get_average_rating">
       <querytext>
            select round(avg(r.rating),1)
              from recruiting_ratings r,
                   recruiting_interviews i
             where r.interview_id = i.interview_id
               and i.candidate_id = :candidate_id
       </querytext>
   </fullquery>

   <fullquery name="get_hire_votes">
       <querytext>
            select count(*)
              from recruiting_interviews i
             where i.candidate_id = :candidate_id
               and i.should_hire_p = 't'
       </querytext>
   </fullquery>

   <fullquery name="get_no_hire_votes"> 
       <querytext>
            select count(*)
              from recruiting_interviews i
             where i.candidate_id = :candidate_id
               and i.should_hire_p = 'f'
       </querytext>
   </fullquery>

</queryset>
