<?xml version="1.0"?>
<queryset>

    <fullquery name="pending_interviews">
        <querytext>
              select u.user_id as interviewer_id,
                     u.first_names||' '||u.last_name as interviewer_name,
                     c.candidate_id,
                     c.first_name||' '||c.last_name as candidate_name,
                     date(a.creation_date) as assigned_date
                from registered_users u,
                     recruiting_candidates c,
                     recruiting_interviews i,
                     acs_objects a
               where i.interviewer_id = u.user_id
                 and i.candidate_id = c.candidate_id
                 and i.interview_id = a.object_id
                 and (select count(*)
                        from recruiting_ratings r
                       where r.interview_id = i.interview_id) = 0;
        </querytext>
    </fullquery>

</queryset>
