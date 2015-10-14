(function(){

  var app = angular.module('store');

   app.controller('StoreController', ['$scope', '$http', function($scope, $http){
    $scope.products = [];

    $scope.index = function(){
      $http.get('/api/products').success(function(data){
        $scope.products = data;
      });
    };

    $scope.create = function(gem) {
      $http.post('/products', { product: gem })
        .success(function(data) {
          $scope.products.push(data.gem);
        })
        .error(function(data) {
          $scope.errors
        });
    };
  }]);

})();
