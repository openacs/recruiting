ad_page_contract {
    recruiting admin interface
    access admin function such as: criteria specification 
                               and interviewee status types

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id:notnull
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

recruiting_candidate::unarchive -candidate_id $candidate_id

ns_returnredirect list-archived-candidates
