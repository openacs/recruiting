<?xml version="1.0"?>
<queryset>

    <fullquery name="my_new_interviews">
        <querytext>
            select i.interview_id,
                   c.candidate_id,
                   c.last_name,
                   c.first_name,
                   c.email,
                   -- c.phone_number,
                   c.city||', '||c.state||' '||c.country as location
              from recruiting_interviews i,
                   recruiting_candidates c
             where i.interviewer_id = :user_id
               and i.candidate_id = c.candidate_id
               and (select count(*)
                      from recruiting_ratings r
                     where r.interview_id = i.interview_id) = 0
        </querytext>
    </fullquery>

</queryset>
