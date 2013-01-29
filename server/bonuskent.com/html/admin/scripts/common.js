
$(document).ready(function() { 
		
	$('#photoimg').live('change', function()			{ 
			   $("#preview").html('');
		$("#preview").html('<img src="loader.gif" alt="Uploading...."/>');
	$("#imageform").ajaxForm({
				target: '#preview'
	}).submit();

	});

	//location image
	$('#locationimg').live('change', function()			{ 
			   $("#locationimg_preview").html('');
		$("#locationimg_preview").html('<img src="loader.gif" alt="Uploading...."/>');
	$("#locationimgform").ajaxForm({
				target: '#locationimg_preview'
	}).submit();

	});
	
	//marker img
	$('#marker-image').live('change', function()			{ 
			   $("#marker-image-preview").html('');
		$("#marker-image-preview").html('<img src="loader.gif" alt="Uploading...."/>');
	$("#marker-imageform").ajaxForm({
				target: '#marker-image-preview'
	}).submit();

	});

	//marker ar img
	$('#marker-ar-image').live('change', function()			{ 
			   $("#marker-ar-image-preview").html('');
		$("#marker-ar-image-preview").html('<img src="loader.gif" alt="Uploading...."/>');
	$("#marker-ar-imageform").ajaxForm({
				target: '#marker-ar-image-preview'
	}).submit();

	});

	//reward img
	$('#rewardimg').live('change', function()			{ 
			   $("#rewardpreview").html('');
		$("#rewardpreview").html('<img src="loader.gif" alt="Uploading...."/>');
	$("#rewardimageform").ajaxForm({
				target: '#rewardpreview'
	}).submit();

	});
	
	
	//Ajax Delete Compaign	
/*	$('#deleteCompaignButton').live('click', function(){ 

		
	});*/

	
}); 
		
		


function increment(elementId){
	var value = $("#"+elementId).val();
	
	if(!value || value.length < 1){
		value=0;
	}
	$("#"+elementId).val(++value);
}

function deccrement(elementId){
	var value = $("#"+elementId).val();
	$("#"+elementId).val(--value);
}


//

function compaignDescriptionFormSubmit(){
	document.getElementById("compaign_description").submit();
}

function compaignLocationFormSubmit(){
	document.getElementById("form1").submit();
}

function congratsFormSubmit(){
	document.getElementById("saveCongratsForm").submit();
}

function rewardFormSubmit(){
	document.getElementById("rewardForm").submit();
}


function editCompaign(url){
	console.log(url);
	window.location = url;
}

function setDeleteCompaign(id){
	console.log(id);
	$("#compaignIdToDelete").val(id);
	return false;
}


function publishCompaign(id, idd){
	
/*		console.log(id);
		console.log(idd);*/
	
		$("#"+id).html('');
		$("#"+id).html('<img src="loader.gif" alt="Publishing...."/>');
		
		//
		var f = document.createElement("form");
		f.setAttribute('method',"post");
		f.setAttribute('id',"publishItemForm");
		f.setAttribute('action',"ajaxpublishcompaign.php");

		var i = document.createElement("input"); //input element, text
		i.setAttribute('type',"hidden");
		i.setAttribute('name',"compaignid");
		i.setAttribute('value',idd);

		f.appendChild(i);

		document.getElementsByTagName('body')[0].appendChild(f);
//
		$("#publishItemForm").ajaxForm({
			target: '#'+id
		}).submit();
		
		console.log("published");
		
		if(document.getElementById("publishItemForm")){
			var element = document.getElementById("publishItemForm");
			document.getElementsByTagName('body')[0].removeChild(element);
		}
		
		return false;	
}

function unPublishCompaign(id, idd){
		$("#"+id).html('');
		$("#"+id).html('<img src="loader.gif" alt="unPublishing...."/>');
		
		//
		var f = document.createElement("form");
		f.setAttribute('method',"post");
		f.setAttribute('id',"unpublishItemForm");
		f.setAttribute('action',"ajaxunpublishcompaign.php");

		var i = document.createElement("input"); //input element, text
		i.setAttribute('type',"hidden");
		i.setAttribute('name',"compaignid");
		i.setAttribute('value',idd);

		f.appendChild(i);

		document.getElementsByTagName('body')[0].appendChild(f);
//
		$("#unpublishItemForm").ajaxForm({
			target: '#'+id
		}).submit();
		
		console.log("unpublished");
		
		if(document.getElementById("unpublishItemForm")){
		var element = document.getElementById("unpublishItemForm");
		document.getElementsByTagName('body')[0].removeChild(element);
		}
		
		return false;	
}



function setDeleteUser(id){
	console.log(id);
	$("#userIdToDelete").val(id);
	return false;
}
