<?xml version="1.0"?>
<queryset>

    <fullquery name="get_interviewer_email">
        <querytext>
             select email as interviewer_email 
               from registered_users 
              where user_id=:search_user_id
        </querytext>
    </fullquery>

    <fullquery name="get_sender_email">
        <querytext>
             select email as sender_email
               from registered_users 
              where user_id=:user_id
        </querytext>
    </fullquery>

</queryset>
