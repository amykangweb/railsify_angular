(function(){

  var app = angular.module('store');

  app.controller("ReviewController", ['$scope', '$http', function($scope, $http){
    this.review = {};

    this.addReview = function(product) {
      this.review.product_id = product.id
      $http.post('api/reviews', { review: this.review })
        .success(function(data){
          product.reviews.push(data.review);
          $scope.review = {};
        }).error(function(data){
          alert("something went wrong.");
        });
    };

  }]);

})();
