module.exports = 
  output:
    directory: "."
  app:
    title: "foo"
    shortname: "bar"
    version: 1
    server: 
      port: 80
      proxy_url: "http://localhost/proxy"
      modules: [
        {
          module: "proxy-express"
          template: "
            app.use proxy('api.bar.com'), '/bar'
          "
        },
        {
          module: "express-api-user-management-signup"
          config: 
            webhook:
              url: 'http://localhost/account'
              requestdata: headers: 'x-some-token': 'l1kj2k323'
            mongo:
              host: 'localhost'
              port: 27017
              name: 'foo'
            layout:
              theme: 'jade'
              title:
                brand: 'Projectname'
                welcome: 'Please login to your account'
              menu:
                'Apidoc':
                  target: '_blank'
                  url: '/api/v1/doc'
                '---': '---'
                'Contact':
                  target: '_blank'
                  url: 'mailto:support@foo.com'
              formurl: '/js/form.json'
          template: "
            usermanagement = require 'express-api-user-management-signup'
            webhookport = process.env.WEBHOOK_HOST || port;
            webhookhost = process.env.WEBHOOK_HOST || 'http://'+ip 
            cfg={{{config}}}
            app.set('port', {{usermanagement.port}};
            app.use(usermanagement(app, express, cfg));"
        }
      ]
    frontend:
      cards:
        home:
          topbar:
            title: "Home"
            buttons:
              back: false
              forward:false
          sections: [
            {
              type: 'mustache'
              data: "<h2>welcome {{name}}</h2><hr>foo bar"
            },{
              type: "data"
              data: 
                mustache: '<ul>{{data}}</ul>'
                type: "url" # ['url','static']
                url: "http://foo.com/flop"
                static:[
                  { name: "Foo", sex: "male" }
                  { name: "Foo", sex: "male" },
                ]
                transform: (data,html) ->
                  for i in data
                    html += mustache.render("{{name}} - {{flop}}", data[i])
            }
          ]
      custom:
        javascript:
          getFoo: 
            frontend: (foo,bar) ->
              console.log "hello world!"
            backend: () ->
              return ["one","two"]
        css:
          stylus: "
            .foo { display:none }
            b    { border:1px solid red; }
            "
