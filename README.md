Put web admin interface-sauce on top of your coffeerest api

<img alt="" src="https://github.com/coderofsalvation/coffeerest-api/raw/master/coffeerest.png" width="20%" />

## Ouch! Is it that simple?

Just add these fields to your coffeerest-api `model.coffee` specification 

    module.exports = 
      ..

## Usage 

    npm install coffeerest-api
    npm install coffeerest-api-frontend-ng-admin 

for more info / servercode see [coffeerest-api](https://www.npmjs.com/package/coffeerest-api)

## Example 


    $ coffee server.coffee &
    registering REST resource: /v1/article (post)
    registering REST resource: /v1/article/:id (get)
    registering REST resource: /v1/article/:id (del)
    registering REST resource: /v1/article/:id (put)
    registering REST resource: /v1/article/tags (post)
    registering REST resource: /v1/article/tags/:id (get)
    registering REST resource: /v1/article/tags/:id (del)
    registering REST resource: /v1/article/tags/:id (put)
    registering REST resource: /v1/user (post)
    registering REST resource: /v1/user/:id (get)
    registering REST resource: /v1/user/:id (del)
    registering REST resource: /v1/user/:id (put)
    registering REST resource: /v1/user/tags (post)
    registering REST resource: /v1/user/tags/:id (get)
    registering REST resource: /v1/user/tags/:id (del)
    registering REST resource: /v1/user/tags/:id (put)

Voila! (....)

