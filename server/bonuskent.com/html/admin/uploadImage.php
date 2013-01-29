  <?php
  
  include("db.php");
  
  $userId = $_REQUEST['userId'];
   $uploaddir = './uploads/';
   $file = basename($_FILES['userfile']['name']);
   $uploadfile = $uploaddir . $file;

  if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
	  	echo "successfully uploaded at http://bonuskent.com/admin/uploads/{$file}";
		echo " user id is : " . $userId;
		echo "  image name is : " . $file;
		
		
		mysql_query("INSERT INTO gallery (imagepath, user_id)
 		VALUES('".$file."', $userId) ") or die(mysql_error()); 
		
  }else{
	  echo "upload failed.";
  }
   
   
    
?>