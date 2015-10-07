module.exports = {
  host: process.env.HOST || "http://localhost:8080"
  doc:
    version: 1
    projectname: "Appic"
    logo: "http://cdn.imgs.steps.dragoart.com/how-to-draw-a-guinea-pig-for-kids-step-5_1_000000100673_5.gif"
    host: process.env.HOST || { "$ref": "#/host" }
    homepage: "http://mydomain.com/about"
    security: "Requests are authorized by adding a 'X-FOO-TOKEN: YOURTOKEN' http header"
    description: "Welcome to the Appic Documentation."
    request: 
      curl: "curl -X {{method}} -H 'Content-Type: application/json' -H 'X-FOO-TOKEN: YOURTOKEN' '{{url}}' --data '{{payload}}' "
      jquery: "jQuery.ajax({ url: '{{url}}', method: {{method}}, data: {{payload}} }).done(function(res){ alert(res); });"
      php: "$client->{{method}}('{{url}}', '{{payload}}');"
      coffeescript: "request.{{method}}\n\theaders: {'X-FOO-TOKEN': apikey }\n\turl: '{{url}}'\n\tjson: true\n\tbody: {{payload}}\n,(error,reponse,body) ->\n\tok = !error and response.statusCode == 200 and response.body"
      nodejs: "request.post({\n\theaders: {\n\t\t'X-FOO-TOKEN': apikey\n\t},\n\turl: '{{url}}',\n\tjson:true,\n\tbody: {{payload}}\n}, function(error, reponse, body) {\n\tvar ok;\n\treturn ok = !error && response.statusCode === 200 && response.body;\n});"
      php: "$json = '{{payload}}';\n$ch = curl_init( '{{url}}' );\ncurl_setopt($ch, CURLOPT_CUSTOMREQUEST, strtoupper('{{method}}') );\ncurl_setopt($ch, CURLOPT_POSTFIELDS, $json);\ncurl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);\ncurl_setopt($ch, CURLOPT_RETURNTRANSFER, true);\ncurl_setopt($ch, CURLOPT_HTTPHEADER, array(\n\t'Content-Type: application/json',\n\t'Content-Length: ' . strlen($json))\n);\n$result = curl_exec($ch);\n// HINT: use a REST client like https://github.com/bproctor/rest\n//       or install one using composer: http://getcomposer.org"
      python: "import requests, json\nurl = '{{url}}'\ndata = json.dumps( {{payload}} )\nr = requests.post( url, data, auth=('user', '*****'))\nprint r.json"

  query_params: [
    {
      id: "#/query_params/populate"
      description: "adds relational data to the result"
      type:"array"
      items:[{type:"string"}]
    },{
      id: "#/query_params/populate2"
      description: "adds relational data to the result"
      type:"array"
      items:[{type:"string"}]
    },{
      id: "#/query_params/populate3"
      description: "adds relational data to the result"
      type:"array"
      items:[{type:"string"}]
    }
  ]

  resources:
    '/ping':
      get:
        description: 'earth to api'
        function: (req, res, next,lib, reply) ->
          lib[ req.params.action ]() if lib[ req.params.action ]?
          return reply 
    
    '/user':
      post:
        description: 'adds user' 
        query_params: 
          populate:  { param: {"$ref": "#/query_params/populate"}, values: ["authors","tags"] }
        required: ['schema_api','schema_ui']
        payload:
          name: { type: "string" }
          age : { type: "number" }

    '/context':
      get:
        description: 'list possible contexts'
        function: (req, res, next,lib, reply) ->
          reply.data = lib.contexts
          return reply 
  
    '/context/:type':
      post:
        description: 'get html frontend'
        notes: 'duplicates are not allowed'
        query_params: 
          populate:  { param: {"$ref": "#/query_params/populate"}, values: ["authors","tags"] }
        required: ['schema_api','schema_ui']
        payload:
          schema_api: { type: "object", default: "see coffeerest-api" }
          schema_ui:  { type: "object",  default: "see GET request" }
        function: (req, res, next,lib, reply) ->
          if req.params.type in lib.contexts
            body = lib.generate req.params.type 
            res.writeHead 200, 
              'Content-Length': Buffer.byteLength(body),
              'Content-Type': 'text/html'
            res.write(body)
            res.end()
          else
            reply.code = 3
            reply.message = "type should be one of "+JSON.stringify lib.contexts
          return reply 
          
  replyschema:
    type: 'object'
    required: ['code','message','kind','data']
    messages:
      0: 'feeling groovy'
      1: 'unknown error'
      2: 'your payload is invalid (is object? content-type is application/json?)'
      3: 'data error'
      4: 'access denied'
    payload:
      code:       { type: 'integer', default: 0 }
      message:    { type: 'string',  default: 'feeling groovy' }
      kind:       { type: 'string',  default: 'default', enum: ['book','default'] }
      data:       { type: 'object',  default: {} }
      errors:     { type: 'object',  default: [] }

}
