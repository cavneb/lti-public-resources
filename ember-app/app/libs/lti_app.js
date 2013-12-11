import ajax from 'appkit/utils/ajax';

var LtiApp = Ember.Object.extend({
  toolId      : null,
  name        : null,
  toolType    : null,
  imageUrl    : null,
  description : null
});

LtiApp.reopenClass({
  find: function() {
    var ltiApps = ajax(Em.ENV.CONFIG.host + '/api/lti_apps').then(
      function(result) {
        var ret = Em.A([]);
        _.each(result.response.lti_apps, function(ltiAppData) {
          ret.addObject(LtiApp.createFromData(ltiAppData));
        }.bind(this));
        return ret;
      }
    );
    return ltiApps;
  },

  findOne: function(toolId) {
    var ltiApp = ajax(Em.ENV.CONFIG.host + '/api/lti_apps/' + toolId).then(function(result) {
      return LtiApp.createFromData(result.response.lti_app);
    });
    return ltiApp;
  },

  createFromData: function(data) {
    return LtiApp.create({
      toolId      : data.tool_id,
      name        : data.name,
      toolType    : data.tool_type,
      imageUrl    : data.image_url,
      description : data.description
    });
  }
});

export default LtiApp;