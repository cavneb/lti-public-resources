import LtiApp from 'appkit/libs/lti-app';

var LtiAppRoute = Ember.Route.extend({
  model: function(params) {
    return LtiApp.findOne(params.toolId);
  },

  setupController: function(controller, context) {
    controller.set('model', context);
  },

  afterModel: function(model, transition) {
    if (model.get('toolType') === 'browse') {
      this.transitionTo('ltiApp.browse');
    } else {
      this.transitionTo('ltiApp.search');
    }
  },

  actions: {
    embedItem: function(returnType, item) {
      // debugger;
      console.log("EMBEDDING ITEM!");
    }
  }
});

export default LtiAppRoute;
