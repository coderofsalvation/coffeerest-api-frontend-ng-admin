      admin.menu(
        nga.menu()
          .addChild(nga.menu()
            .title('{{{title}}}')
            .link('{{{link}}}')
            .active(function(path) { return path.indexOf('{{{link}}}') === 0; })
          {{#children}}
            .addChild(nga.menu()
              .title('{{{title}}}')
              .link('{{{link}}}')
              .active(function(path) { return path.indexOf('{{{link}}}') === 0; })
            )
          {{/children}}
          )
      );
