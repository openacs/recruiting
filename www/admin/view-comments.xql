<?xml version="1.0"?>
<queryset>

   <fullquery name="get_comments">
       <querytext>
           select u.first_names||' '||u.last_name as interviewer_name,
                  i.interview_id,
                  i.comment
             from registered_users u,
                  recruiting_interviews i
            where u.user_id = i.interviewer_id
              and i.candidate_id = :candidate_id
       </querytext>
   </fullquery>

</queryset>
