var Router = Ember.Router.extend(); // ensure we don't share routes between all Router instances

Router.map(function() {
  this.resource('ltiApps', { path: '/' });
  this.resource('ltiApp', { path: '/:toolId' });
});

export default Router;
