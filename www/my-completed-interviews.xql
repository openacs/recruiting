<?xml version="1.0"?>
<queryset>

    <fullquery name="my_completed_interviews">
        <querytext>
            select i.interview_id,
                   c.candidate_id,
                   c.last_name,
                   c.first_name,
                   c.email,
                   -- c.phone_number,
                   c.city||', '||c.state||' '||c.country as location,
                   round((select avg(r.rating)
                               from recruiting_ratings r
                              where interview_id = i.interview_id),1) as average_rating,
                  (CASE
                      WHEN i.should_hire_p = 't'
                      THEN 'Yes'
                      WHEN i.should_hire_p = 'f'
                      THEN 'No'
                   END) as should_hire_p                  
              from recruiting_interviews i,
                   recruiting_candidates c
             where i.interviewer_id = :user_id
               and i.candidate_id = c.candidate_id
               and (select count(*)
                      from recruiting_ratings r
                     where r.interview_id = i.interview_id) != 0
        </querytext>
    </fullquery>

</queryset>
