//= require js-routes
//= require angular
//https://github.com/railsware/js-routes#what-about-security

//angular and turbolink ._.
//currently the problem is solved with 'data-no-turbolink'
//TODO: find a better method to deal with this problem

//TODO: use strict

var app = angular.module('samarnmitrPOS', []);

app.controller('POSCtrl', ['$scope', '$http', function($scope, $http) {
    //initialize shopping cart
    $scope.init = function() {
      $scope.cart = {items:[],  combos:[]};
      $scope.customer = {name: '', info: ''};
    };
    $scope.init();

    function raiseHttpError() {
        alert('Error occurred!\nPlease reload the page');
    };

    //get products list
    $scope.getProduct = function() {
        $http.get(Routes.pos_products_path())
        .then(function(response) {
            $scope.products = response.data; // for ng-repeat
            $scope.product = {}; // hash table
            angular.forEach(response.data, function(item) {
                $scope.product[item.id] = {name: item.name, price: item.price};
            });
            $scope.getCombo();
        }, raiseHttpError);
    };
    $scope.getProduct();

    //get combos list
    $scope.getCombo = function() {
        $http.get(Routes.pos_combos_path())
        .then(function(response) {
            $scope.combos = response.data;
            $scope.combo = {};
            angular.forEach(response.data, function(item) {
                $scope.combo[item.id] = { name: item.name, price: item.price, products: item.products };
            });
            $scope.loadCart();
        }, raiseHttpError);
    };

    // for pos#edit
    $scope.loadCart = function() {
      if($scope.cart2Load) {
        $scope.cart = $scope.cart2Load.cart;
        $scope.customer = $scope.cart2Load.customer;
      }
    };

    $scope.addProduct2Cart = function(product) {
        var item = {id: product.id, quantity: 1};
        $scope.cart.items.push(item);
    };

    // initialize or else search.id will be undefined
    $scope.search = { id: '' };

    $scope.comp = function(actual, expected) {
        if (expected == '') return true;
        return angular.equals(actual, parseInt(expected));
    };

    $scope.addById = function() {
        if($('.nav-tabs .active').text() == 'Products') {
            if ($scope.search.id == '') {
                var len = $scope.cart.items.length;
                if (len > 0) {
                    $scope.cart.items[len - 1].quantity ++;
                }
            }
            else if ($scope.result.length == 1) {
                $scope.addProduct2Cart($scope.result[0]);
                $scope.search.id = '';
            }
        }
    };

    $scope.showComboModal = function(combo) {
      $scope.currentCombo = combo;
      $("input[name^='choice-']").prop("checked", false);
      $('#comboModal').modal('show');
    };

    $scope.isArray = Array.isArray;

    $scope.addCombo2Cart = function() {
        if($(".choice:not(:has(:radio:checked))").length > 0) {
            alert("At least one group is blank");
        }
        else {
            var item = {id: $scope.currentCombo.id, selected: []};
            $("input[name^='choice-']:checked").each(function() {
                item.selected.push(parseInt($(this).val()));
            });
            $scope.cart.combos.push(item);
            $('#comboModal').modal('hide');
        }
    };

    $scope.comboItems = function (id, selected) {
        var result = [], pointer = 0;
        angular.forEach($scope.combo[id].products, function(item) {
            if(Array.isArray(item)) {
                result.push($scope.product[item[selected[pointer]]].name);
                pointer++;
            }
            else {
                result.push($scope.product[item].name);
            }
        });
        return result;
    };

    $scope.deleteCartItem = function(item) {
        var index = $scope.cart.items.indexOf(item);
        if (index != -1) {
            $scope.cart.items.splice(index, 1);
        }
    };

    $scope.deleteCartCombo = function(combo) {
        var index = $scope.cart.combos.indexOf(combo);
        if (index != -1) {
            $scope.cart.combos.splice(index, 1);
        }
    };

    $scope.customQuantity = function(item) {
        var newQ = prompt('Enter quantity', item.quantity);
        if (newQ) {
            newQ = parseInt(newQ);
            if (!isNaN(newQ) && newQ > 0) {
                item.quantity = newQ;
            }
        }
    };

    $scope.cartTotal = function() {
        var total = 0;
        angular.forEach($scope.cart.items, function(item) {
            total += $scope.product[item.id].price * item.quantity;
        });
        angular.forEach($scope.cart.combos, function(item) {
            total += $scope.combo[item.id].price;
        });
        return total;
    };

    $scope.cartIsEmpty = function() {
        return $scope.cart.items.length + $scope.cart.combos.length == 0;
    };

    // TODO: change to modal
    $scope.clear = function() {
        if(confirm("Clear shopping cart?")) {
            $scope.init();
        }
    };
}]);
