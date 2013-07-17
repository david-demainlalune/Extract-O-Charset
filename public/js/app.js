'use strict'


var dbg;

function ExtractController($scope, $http){

	$scope.textAreaContent = "pipo";

	dbg = $scope;

	
	var send = function(text){
		
		var data = {text: text};
		console.log(data);

		$http({method: 'POST', url:'api_extract', data: data}).
        success(function(data, status, headers, config){
            
            console.log("success");
            console.log(data);
        }).
        error(function(data, status, headers, config){
            // flash.pushErrorMessage("error on update of " + $scope.document.inv);
            console.log("error");
        });
    }

	$scope.extractCharSet = function(){
		send($scope.textAreaContent);
	};
}