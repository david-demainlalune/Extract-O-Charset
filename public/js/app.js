'use strict'

function ExtractController($scope, $http){

	$scope.textAreaContent = "test1289HHH.-";
	$scope.report = null;

	dbg = $scope;

	var successNotification = function(message){
	    $('#notifications').notify({
			message: { text: message },
			type: 'success'
		}).show(); 
	};

	var errorNotification = function(message){
	    $('#notifications').notify({
			message: { text: message },
			type: 'error'
		}).show(); 
	};

	var handleResponse = function(response){
		
		if (response.success){
			$scope.report = response.report;
			successNotification("report successfully generated");
			$("#report").css({opacity : 0}).animate({ opacity : 1 }, 500);
		}else{
			errorNotification(response.message);
		}
	};
	
	var send = function(text){
		
		var data = {text: text};

		$http({method: 'POST', url:'api_extract', data: data}).
        success(function(data, status, headers, config){
            handleResponse(data);
        }).
        error(function(data, status, headers, config){
            errorNotification("server error code " + status);
        });
    };

	$scope.extractCharSet = function(){
		send($scope.textAreaContent);
		successNotification("text submitted");
	};
}