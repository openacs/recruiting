<?xml version="1.0"?>
<queryset>

   <fullquery name="get_ratings_by_criteria">
       <querytext>
            select u.user_id as interviewer_user_id,
                   u.first_names||' '||u.last_name as interviewer_name,
                   r.rating
              from recruiting_ratings r,
                   registered_users u
             where r.criteria_id = :criteria_id
               and r.interview_id = recruiting_interviews.interview_id
               and recruiting_interviews.candidate_id = :candidate_id
               and recruiting_interviews.interviewer_id = u.user_id
       </querytext>
   </fullquery>

   <fullquery name="get_average_rating_by_criteria">
       <querytext>
            select round(avg(r.rating),1)
              from recruiting_ratings r,
                   recruiting_interviews i
             where r.criteria_id = :criteria_id
               and r.interview_id = i.interview_id
               and i.candidate_id = :candidate_id
       </querytext>
   </fullquery>

</queryset>
