<?xml version="1.0"?>

<queryset>

    <fullquery name="select_users">
        <querytext>
            select user_id as search_user_id,
                   first_names,
                   last_name,
                   email
            from registered_users
            where lower(last_name) like lower('%' || :search_text || '%')
            or lower(first_names) like lower('%' || :search_text || '%')
            or lower(email) like lower('%' || :search_text || '%')
            and user_id in (select user_id
                                from dotlrn_users)
        </querytext>
    </fullquery>

</queryset>
