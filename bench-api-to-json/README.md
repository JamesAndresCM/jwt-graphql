## Env vars
```
cp env_sample .env; DEVISE_JWT_SECRET_KEY=$(rails secret); sed -i '' "s/DEVISE_JWT_SECRET_KEY=/DEVISE_JWT_SECRET_KEY=$DEVISE_JWT_SECRET_KEY/" .env;
```

## Setup
```
bundle install
```

## Endpoints

#### Login
```
curl -H 'Content-Type: application/json' -d '{"email": "user@domain.com","password": "password"}' localhost:3000/login
```

#### Open Routes
```
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer token' localhost:3000/api/v1/open_routes?date=2020-01-15
```

### Home
```
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer token' localhost:3000/api/v1/home
```

## Init Dispatches
### Custom Filters
#### possible filters: string (is_pickup, has_form, is_trunk)
#### filter_value: boolean
#### Example: (filter: "is_pickup", filter_value: true)
```
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer token' localhost:3000/api/v1/init_dispatches?date=2020-01-15&filter_value=true&filter=is_trunk
```

## Current User
```
curl -H 'Content-Type: application/json' -H 'Authorization: Bearer token' localhost:3000/api/v1/current_user
```

