ad_page_contract {
    recruiting admin interface
    new candidate page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

# check if there are status types defined.  if not,
# don't let any candidates be created (what would their
# status type be)?

set status_type_count [db_string get_status_type_count {}]

form create new_candidate
element create new_candidate first_name \
        -label "First Name:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate last_name \
        -label "Last Name:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate address1 \
        -label "Address 1:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate address2 \
        -label "Address 2:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -optional

element create new_candidate city \
        -label "City:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate state \
        -label "State:" \
        -datatype text \
        -widget text \
        -html {size 2}

element create new_candidate zip \
        -label "Zip:" \
        -datatype text \
        -widget text \
        -html {size 5} \
        -optional

element create new_candidate zip_plus_four \
        -label {Zip Plus 4:} \
        -datatype text \
        -widget text \
        -html {size 4} \
        -optional

element create new_candidate country \
        -label "Country:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -optional

element create new_candidate home_phone \
        -label "Home phone:" \
        -datatype text \
        -widget text \
        -html {size 14} \
        -optional

element create new_candidate cell_phone \
        -label "Mobile phone:" \
        -datatype text \
        -widget text \
        -html {size 14} \
        -optional

element create new_candidate email \
        -label "Email:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate status \
        -label "Status (<a href=\"javascript:openPage('status-help',400,300)\">help</a>):" \
        -datatype integer \
        -widget select \
        -options [db_list_of_lists get_status_types "select short_desc,status_type_id from recruiting_status_types where enabled_p='t' order by short_desc"]

if {[form is_valid new_candidate]} {
    form get_values new_candidate \
            first_name last_name \
            address1 address2 city state zip zip_plus_four country \
            home_phone cell_phone \
            email status    
    
    set person_id [person::new \
            -first_names $first_name \
            -last_name $last_name]

    recruiting_candidate::new \
            -candidate_id $person_id \
            -first_name $first_name \
            -last_name $last_name \
            -address1 $address1 \
            -address2 $address2 \
            -city $city \
            -state $state \
            -zip $zip \
            -zip_plus_four $zip_plus_four \
            -country $country \
            -home_phone [recruiting_candidate::strip_phone -phone_number $home_phone] \
            -cell_phone [recruiting_candidate::strip_phone -phone_number $cell_phone] \
            -email $email \
            -status $status
    
    ns_returnredirect list-candidates
    ad_script_abort
}

set context_bar [list [list "../" "Recruiting"] [list "index" "Admin"] [list "list-candidates" "Candidates"] "New Candidate"]

ad_return_template
