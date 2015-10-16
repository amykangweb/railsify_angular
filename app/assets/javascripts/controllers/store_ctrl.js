(function(){

  var app = angular.module('store');

   app.controller('StoreController', ['$scope', '$http', function($scope, $http){
    $scope.products = [];
    $scope.username = "none";
    $scope.token;
    $scope.admin;

  $scope.flash = function(){
    if ($scope.username != "none") {
      return true;
    }else{
      return false;
    }
  };

   $scope.session = function(user){
      $http.post('api/sessions' + "?username=" + user.username + "&" + "password=" + user.password).success(function(data){
        $scope.username = data.user.username;
        $scope.token = data.token;
        $scope.admin = data.user.admin;
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
          $scope.errors;
        });
      };

    $scope.update = function(product) {
      $http.path('api/products' + product.id, { product: product })
        .success(function(data) {

      }).error(function(data) {
        $scope.errors;
      });
    };
  }]);

})();
