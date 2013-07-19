'use strict'


var dbg;


function ExtractController($scope, $http){

	$scope.textAreaContent = "test";
	$scope.report = {};

	dbg = $scope;

	var successNotification = function(message){
	    $('#notifications').notify({
			message: { text: message },
			type: 'success'
		}).show(); 
	}

	var errorNotification = function(message){
	    $('#notifications').notify({
			message: { text: message },
			type: 'error'
		}).show(); 
	}

	
	var send = function(text){
		
		var data = {text: text};
		console.log(data);
		
		$http({method: 'POST', url:'api_extract', data: data}).
        success(function(data, status, headers, config){
            
            console.log("success");
            console.log(data);
            errorNotification("hello");

            $scope.report = data.report;

        }).
        error(function(data, status, headers, config){
            // flash.pushErrorMessage("error on update of " + $scope.document.inv);
            errorNotification("server error code " + status);
        });
    }

	$scope.extractCharSet = function(){
		send($scope.textAreaContent);
	};
}