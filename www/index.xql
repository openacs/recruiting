<?xml version="1.0"?>
<queryset>

    <fullquery name="num_new_interviews">
        <querytext>
            select count(*)
              from recruiting_interviews i
             where i.interviewer_id = :user_id
               and (select count(*)
                      from recruiting_ratings r
                     where r.interview_id = i.interview_id) = 0
        </querytext>
    </fullquery>

    <fullquery name="num_old_interviews">
        <querytext>
            select count(*)
              from recruiting_interviews i
             where i.interviewer_id = :user_id
               and (select count(*)
                      from recruiting_ratings r
                     where r.interview_id = i.interview_id) != 0
        </querytext>
    </fullquery>

</queryset>
