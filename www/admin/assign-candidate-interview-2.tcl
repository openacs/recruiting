ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
    search_user_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

recruiting_interview::new \
        -interviewer_id $search_user_id \
        -candidate_id $candidate_id \
        -package_id $package_id

ns_returnredirect view-one-candidate?[export_vars candidate_id]
