<?php
include('db.php');
session_start();
$path = "uploads/";

	$valid_formats = array("jpg", "png", "gif", "bmp");
	if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST")
		{
			$name = $_FILES['marker-image']['name'];
			$size = $_FILES['marker-image']['size'];
			
			if(strlen($name))
				{
					list($txt, $ext) = explode(".", $name);
					if(in_array($ext,$valid_formats))
					{
					if($size<(1024*1024))
						{
							$actual_image_name = time().substr(str_replace(" ", "_", $txt), 5).".".$ext;
							$tmp = $_FILES['marker-image']['tmp_name'];
							if(move_uploaded_file($tmp, $path.$actual_image_name))
								{
									mysql_query("UPDATE compaign SET marker_image_path='$actual_image_name' WHERE id=".$_SESSION['compaignId']." ");
									
									echo "<img src='uploads/".$actual_image_name."'  class='preview'>";
								}
							else
								echo "failed";
						}
						else
						echo "Image file size max 1 MB";					
						}
						else
						echo "Invalid file format..";	
				}
				
			else
				echo "Please select image..!";
				
			exit;
		}
?>