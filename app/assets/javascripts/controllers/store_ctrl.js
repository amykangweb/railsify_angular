(function(){

  var app = angular.module('store');

   app.controller('StoreController', ['$scope', '$http', '$cookies', function($scope, $http, $cookies){
    $scope.loggedIn = $cookies.get('loggedin');
    $scope.products = [];
    $scope.username = "none";
    $scope.token;
    $scope.admin;

    if($scope.loggedIn == "true") {

      $scope.username = $cookies.get('username');
      $scope.token = $cookies.get('token');
      $scope.admin = $cookies.get('admin');

    };

  $scope.flash = function(){
    if ($scope.username != "none") {
      return true;
    }else{
      return false;
    }
  };

  $scope.isAdmin = function(){
    if($scope.admin === "true") {
      return true;
    }else{
      return false;
    }
  };

   $scope.session = function(user){
      $http.post('api/sessions' + "?username=" + user.username + "&" + "password=" + user.password).success(function(data){
        $cookies.put('loggedin', 'true');
        $cookies.put('username', data.user.username);
        $cookies.put('admin', data.user.admin);
        $cookies.put('token', data.token);
        $scope.username = $cookies.get('username');
        $scope.token = $cookies.get('token');
        $scope.admin = $cookies.get('admin');
      }).error(function(data){
        alert("Something went wrong.");
      });
    };

    $scope.logout = function(username){
      $http.delete('api/sessions' + '?username=' + $scope.username).success(function(data){
        $scope.username = "none";
        $cookies.remove('loggedin');
        $cookies.put('username', 'none');
        $cookies.remove('token');
        $cookies.put('admin', 'false');
        $scope.loggedIn = $cookies.get('loggedin');
        $scope.username = $cookies.get('username');
        $scope.token = $cookies.get('token');
        $scope.admin = $cookies.get('admin');
      }).error(function(data) {
        alert("Something went wrong.");
      });
    };


    $scope.index = function(){
      $http.get('api/products').success(function(data){
        $scope.products = data.products;
      });
    };

    $scope.create = function(product) {
        $http.post('api/products' + "?" + "api_secret=" + $scope.token + "&" + "username=" + $scope.username, { product: product })
          .success(function(data) {
            $scope.products.push(data.product);
            $scope.newGem.$setPristine();
        })
        .error(function(data) {
          alert("Something went wrong.");
          $scope.errors;
        });
      };

    $scope.update = function(product) {
      $http.path('api/products' + product.id, { product: product })
        .success(function(data) {

      }).error(function(data) {
        alert("Something went wrong.");
        $scope.errors;
      });
    };
  }]);

})();
