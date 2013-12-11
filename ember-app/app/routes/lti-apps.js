import LtiApp from 'appkit/libs/lti_app';

var LtiAppsRoute = Ember.Route.extend({
  model: function(params) {
    return LtiApp.find();
  }
});

export default LtiAppsRoute;

