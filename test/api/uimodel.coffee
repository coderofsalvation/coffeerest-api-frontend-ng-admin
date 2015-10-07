module.exports = 
  model: { "$ref": __dirname + "/model.coffee" }
  login: 
    enabled: false
    url: "/login"
  resources: { "$ref": "#/model/resources" }

  menu: 
    title: "Project foo"
    items: [
      title: "Users"
      link: "/user"
      views: [
        type: "listing"
        fields: { "$ref": "#/model/resources['\\/user']/post/payload" }
      ]
      children: [
        title: "Hobbits"
        link: "/hobbits"
        views: [
          type: "listing"
          fields: { "$ref": "#/model/resources['\\/user']/post/payload" }
        ]
      ]
    ]
