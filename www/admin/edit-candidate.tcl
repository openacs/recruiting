ad_page_contract {
    recruiting admin interface
    new candidate page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
} {
    candidate_id
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

# check if there are status types defined.  if not,
# don't let any candidates be created (what would their
# status type be)?

array set info [recruiting_candidate::get -candidate_id $candidate_id]

form create edit_candidate
element create edit_candidate first_name \
        -label "First Name:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(first_name)

element create edit_candidate last_name \
        -label "Last Name:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(last_name)

element create edit_candidate address1 \
        -label "Address 1:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(address1)

element create edit_candidate address2 \
        -label "Address 2:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -optional \
        -value $info(address2)

element create edit_candidate city \
        -label "City:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(city)

element create edit_candidate state \
        -label "State:" \
        -datatype text \
        -widget text \
        -html {size 2} \
        -value $info(state)

element create edit_candidate zip \
        -label "Zip:" \
        -datatype text \
        -widget text \
        -html {size 5} \
        -optional \
        -value $info(zip)

element create edit_candidate zip_plus_four \
        -label {Zip Plus 4:} \
        -datatype text \
        -widget text \
        -html {size 4} \
        -optional \
        -value $info(zip_plus_four)

element create edit_candidate country \
        -label "Country:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(country)

element create edit_candidate email \
        -label "Email:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -value $info(email)

element create edit_candidate status \
        -label "Status (<a href=\"javascript:openPage('status-help',400,300)\">help</a>):" \
        -datatype integer \
        -widget select \
        -options [db_list_of_lists get_status_types "select short_desc,status_type_id from recruiting_status_types where enabled_p='t' order by short_desc"] \
        -value $info(status)

element create edit_candidate candidate_id \
        -widget hidden \
        -value $candidate_id

if {[form is_valid edit_candidate]} {
    form get_values edit_candidate \
            first_name last_name \
            address1 address2 city state zip zip_plus_four country \
            email status    
    
    recruiting_candidate::update_candidate \
            -candidate_id $candidate_id \
            -first_name $first_name \
            -last_name $last_name \
            -address1 $address1 \
            -address2 $address2 \
            -city $city \
            -state $state \
            -zip $zip \
            -zip_plus_four $zip_plus_four \
            -country $country \
            -email $email \
            -status $status \
            -package_id $package_id
    
    ad_returnredirect list-candidates
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "Edit Candidate"]

ad_return_template
