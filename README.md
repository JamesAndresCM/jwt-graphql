# Rails 5 JWT & graphQL


## Env vars
```
cp env_sample .env; DEVISE_JWT_SECRET_KEY=$(rails secret); sed -i '' "s/DEVISE_JWT_SECRET_KEY=/DEVISE_JWT_SECRET_KEY=$DEVISE_JWT_SECRET_KEY/" .env;
```

## Setup:
```
bundle install
rails db:create db:migrate db:seed
```

## Create user with mutation (signUp) and set token

## Mutations
```
mutation signUp {
  signUp(
    input: {
      email: "user@domain.com",
      password: "12345678",
      password_confirmation: "12345678",
      firstName: "user",
      lastName: "last",
      accountEmail: "graphql@domain.com"
    }
  ){
    user{
        id
        token
    }
    errors { 
      fullMessages
    }
  }
}

mutation login{
  login(
    input: {
      email: "user@domain.com",
      password: "12345678910"
    }
  ){
    user{
      id
      token
    }
  }
}

mutation sendResetPass{
  sendResetPass(input: {email: "user@domain.com"}){
    status
  }
}

mutation resetPassword{
  resetPassword(
    input: {
      reset_password_token: "token",
      password: "password",
      password_confirmation: "password_confirmation"
    }
  ){
    status
  }
}

mutation tokenLogin{
  tokenLogin(input: {}){
    user{
      token
    }
  }
}

mutation updateUser{
  updateUser(
    input: {
      first_name: "first",
      last_name: "last",
      password: "12345678",
      password_confirmation: "12345678"
    }
  ){
    user{
      id
      token
    }
    errors{
      fullMessages
    }
  }
}

mutation logout{
  logout(input: {}){
    status_logout
  }
}
```
## Queries
```
query current_user {
  current_user {
    firstName
    lastName
    email
    account {
      id
      name
      email
      api_key
      places {
        id
        address
        name
      }
      truck_drivers {
        id
        name
        username
        pin_code
        created_at
        truck_driver_availabilities {
          truck_driver_id
          place_id
          available
          longitude
          latitude
          created_at
        }
        truck {
          id
          has_own_gps
          identifier
          active
          vehicle_type
          capacity
          routes {
            id
            active
            dispatch_date
            start_time
            end_time
            dispatches {
              id
              route_id
              status_id
              estimated_at
              arrived_at
              slot
              has_form
              guide {
                id
                account_id
                code
                dispatches_count
                place_id
                first_estimated
                service_time
                min_delivery_time
                max_delivery_time
                beecode
                active
                mode
                custom_fields {
                  id
                  custom_field_type_id
                  model_id
                  model_type
                  value
                  created_at
                  custom_field_type {
                    id
                    name
                    model_type
                    show_in_web
                    show_in_mobile
                    has_many_flag
                    created_at
                  }
                }
                address {
                  id
                  account_id
                  name
                  name_correct
                  city
                  state
                  postal_code
                  latitude
                  latitude_proposed
                  longitude
                  longitude_proposed
                  country
                  geocoding_status
                }
                contact {
                  id
                  account_id
                  email
                  phone
                  identifier
                  name
                  contact_type
                  last_sent_survey
                }
              }
            }
          }
        }
      }
    }
  }
}
```
### Parameters for pagination (first, last, before, after) [more info](https://graphql.org/learn/pagination/)
```
query account_open_routes {
  account_open_routes(date: "2020-01-15", first: 3) {
    totalCount
    pageInfo {
      endCursor
      startCursor
      hasPreviousPage
      hasNextPage
    }
    edges {
      cursor
      node {
        id
        active
        dispatch_date
        start_time
        end_time
        dispatches {
          id
          route_id
          status_id
          estimated_at
          arrived_at
          slot
          has_form
          guide {
            id
            account_id
            code
            dispatches_count
            place_id
            first_estimated
            service_time
            min_delivery_time
            max_delivery_time
            beecode
            active
            mode
            custom_fields {
              id
              custom_field_type_id
              model_id
              model_type
              value
              created_at
              custom_field_type {
                id
                name
                model_type
                show_in_web
                show_in_mobile
                has_many_flag
                created_at
              }
            }
            address {
              id
              account_id
              name
              name_correct
              city
              state
              postal_code
              latitude
              latitude_proposed
              longitude
              longitude_proposed
              country
              geocoding_status
            }
            contact {
              id
              account_id
              email
              phone
              identifier
              name
              contact_type
              last_sent_survey
            }
          }
        }
      }
    }
  }
}
````
## Custom Filters 
### possible filters: string (is_pickup, has_form, is_trunk) 
### filter_value: boolean
### Example: (filter: "is_pickup", filter_value: true)
````
query init_dispatches {
  initDispatches(date: "2020-01-15") {
    totalCount
    pageInfo {
      endCursor
      startCursor
      hasPreviousPage
      hasNextPage
    }
    edges {
      cursor
      node {
        id
        route_id
        status_id
        estimated_at
        arrived_at
        slot
        has_form
        route {
          id
          active
          dispatch_date
          start_time
          end_time
        }
        guide {
          id
          account_id
          code
          dispatches_count
          place_id
          first_estimated
          service_time
          min_delivery_time
          max_delivery_time
          beecode
          active
          mode
          custom_fields {
            id
            custom_field_type_id
            model_id
            model_type
            value
            created_at
            custom_field_type {
              id
              name
              model_type
              show_in_web
              show_in_mobile
              has_many_flag
              created_at
            }
          }
          address {
            id
            account_id
            name
            name_correct
            city
            state
            postal_code
            latitude
            latitude_proposed
            longitude
            longitude_proposed
            country
            geocoding_status
          }
          contact {
            id
            account_id
            email
            phone
            identifier
            name
            contact_type
            last_sent_survey
          }
        }
      }
    }
  }
}
```
