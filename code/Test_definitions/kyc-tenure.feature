Feature: CAMARA Tenure API, v0.1.0-rc.1 - Operation check-tenure
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    #
    # Testing assets:
    # * A mobile line identified by its phone number "phoneNumber"
    #
    # References to OAS spec schemas refer to schemas specifies in kyc-tenure.yaml, version 0.1.0-rc.1

    Background: Common checkTenure setup
        Given an environment at "apiRoot"
        And the resource "/kyc-tenure/v0.1-rc1/check-tenure"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" is set to a UUID value
        And the request body is set by default to a request body compliant with the schema

    
    # Happy path scenarios
    
    @checkTenure_1_tenure_check_true
    Scenario: Validate successful response when tenureDateCheck is true
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.tenureDate" is set to a valid past date in format RFC 3339 / ISO 8601
        And the mobile subscription has had a valid tenure since the provided tenure date
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/TenureInfo"
        And the response property "$.tenureDateCheck" is true
        And if the response contains property "$.contractType", the value is one of ["PAYG", "PAYM", "Business"]
    
    @checkTenure_2_tenure_check_false
    Scenario: Validate successful response when tenureDateCheck is false
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.tenureDate" is set to a valid past date in format RFC 3339 / ISO 8601
        And the mobile subscription hasn't had a valid tenure since the provided tenure date
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/TenureInfo"
        And the response property "$.tenureDateCheck" is false
        And if the response contains property "$.contractType", the value is one of ["PAYG", "PAYM", "Business"]

    
    # Generic 400 errors

    @checkTenure_400.1_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @checkTenure_400.2_empty_request_body
    Scenario: Empty object as request body
        Given the request body is set to "{}"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @check_device_swap_400.3_out_of_range
    Scenario: Error when tenureDate is out of range
        Given the request body property "$.tenureDate" is set to a value in the future
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "OUT_OF_RANGE"
        And the response property "$.message" contains a user friendly text
    
    @checkTenure_400.4_invalid_argument
    Scenario: Invalid Argument. Generic Syntax Exception
        Given the request body is set to any value which is not compliant with the OAS schema at "/components/schemas/TenureDate"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @checkTenure_400.4_phone_number_not_schema_compliant
    Scenario: Phone number value does not comply with the schema
        Given the header "Authorization" is set to a valid access which does not identify a single phone number
        And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    
    # Generic 401 errors

    @checkTenure_401.1_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @checkTenure_401.2_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token which is invalid for reasons other than lifetime expiry
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @checkTenure_401.3_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401

    
    # Generic 404 errors

    # Typically with a 2-legged access token
    @checkTenure_404.1_phone_number_not_found
    Scenario: Phone number not found
        Given the header "Authorization" is set to a valid access token from which the phone number cannot be deducted
        And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid subscription managed by the API provider
        When the HTTP "POST" request is sent
        Then the response status code is 404
        And the response property "$.status" is 404
        And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    
    # Generic 422 errors

    @checkTenure_422.1_service_not_applicable
    Scenario: Service not applicable for the phone number
        Given that service is not supported for all phone numbers managed by the network operator
        And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
        And the response property "$.message" contains a user friendly text

    @checkTenure_422.2_missing_identifier
    Scenario: No valid identifier has been provided
        Given the header "Authorization" is set to a valid access token from which the phone number cannot be deducted
        And the request body property "$.phoneNumber" is not present
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "MISSING_IDENTIFIER"
        And the response property "$.message" contains a user friendly text
    
    # Only with a 3-legged access token
    @checkTenure_422.3_unnecessary_identifier
    Scenario: No valid identifier has been provided
        Given a valid testing phone number supported by the service, identified by the access token
        And the request body property "$.phoneNumber" is set to a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

