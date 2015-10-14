(function(){

  var app = angular.module('store');

   app.controller('StoreController', ['$scope', '$http', function($scope, $http){
    $scope.products = [];

    $scope.index = function(){
      $http.get('/api/products').success(function(data){
        $scope.products = data.products;
      });
    };

    $scope.create = function(product) {
      console.log(product);
      $http.post('api/products', { product: product })
        .success(function(data) {
          $scope.products.push(data.product);
          $scope.newGem.$setPristine();
      })
      .error(function(data) {
        $scope.errors
      });
    };
  }]);

})();
