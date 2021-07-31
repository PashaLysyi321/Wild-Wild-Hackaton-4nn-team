import os
import Algorithmia
import json
from PIL import Image
import numpy as np
import os
from torchvision.transforms import Compose, Resize, CenterCrop, ToTensor, Normalize
import torch
from werkzeug.utils import secure_filename 
from flask import Flask, request, redirect, url_for
from zipfile import ZipFile
from flask import send_from_directory 
import zipfile
import shutil

app = Flask(__name__)

UPLOAD_FOLDER = 'input_images' 
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'bmp', 'NEF']) 
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER 

preprocess = Compose([
	Resize(224),
	CenterCrop(224),
	ToTensor()
])
 
def allowed_file(filename): 
	return '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS 
 
def text_for_json(images,texts):
	st = '{"images": ' + str(images) + ',"classes": ' + '['
	for text in texts:
		st += '"' + text + '",'
	st = st[0:-1] + ']}'
	return st

@app.route('/', methods=['GET', 'POST']) 
 
def upload_file(): 
	if request.method == 'POST': 
		try:
			shutil.rmtree("input_images")
			shutil.rmtree("output_classes")
		except:pass
		os.makedirs('input_images',exist_ok=True) 
		for file in request.files.getlist("file"): 
			if file and allowed_file(file.filename): 
				filename = file.filename 
				file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename)) 
	return ''' 
	<!doctype html> 
	<html>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script> 
	var intTextBox = 3;  
	function addElement()  
	{ 
		intTextBox = intTextBox + 1; 
		var contentID = document.getElementById('content'); 
		var howManyTextBoxes = intTextBox;   
		var newTBDiv = document.createElement('div');            
		newTBDiv.setAttribute('id', 'strText' + intTextBox); 
		newTBDiv.innerHTML += `<p><input type=text name = class${intTextBox}>`;                              
		contentID.appendChild(newTBDiv);    
		return False                      
	} 
	</script> 
	<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	</head>
	<body style="background-color:#000000;">
	<div class="container-fluid w3-black"  align="center">
        <br><p>
        <span class="navbar-brand mb-0 w3-xxxlarge">ImageSortNet can help you to sort your photo.</span>
        <span class="navbar-brand mb-0 w3-xxxlarge">Enter your photo, click upload, write your class and click sort!</span><br><p><br><p>
        <br><p>
    </div>
	<div class="container" align="center">
	  <form action="" method=post enctype=multipart/form-data> 
		<p><input type=file name=file multiple class="w3-button w3-black w3-xxlarge w3-hover-aqua"> <input type=submit class="w3-xxxlarge w3-button w3-black w3-hover-aqua" value=Upload> 
		</form>
	</div>
	<div class="container-fluid w3-black"  align="center">
        <br><p>
        <span class="navbar-brand mb-0 w3-xxxlarge">User classes</span>
    </div>
	<div class="container w3-xxlarge" align="center">
		<form id=content action="sort" method=post><br>
		  <p><input type=text name = class1> 
		  <p><input type=text name = class2>
		  <p><input type=text name = class3><p><p>
		  <p><a href="javascript:addElement();"><input type="button" class="w3-button w3-black w3-xxxlarge w3-hover-aqua" value="Add class"></a> 
		  <input type=submit value=Sort class="w3-button w3-black w3-xxxlarge w3-hover-aqua">
		</form>
	</div>
    <div class="container-fluid w3-black  w3-xxlarge"  align="center">
        <br><p>
        <br><p>
        <span class="navbar-brand mb-0 w3-xxxlarge">Created by Lysyi Pavlo, Bektimirov Alim and Alexandr Bondarchuk</span><br><p>
        <form align="center" class="w3-black w3-button w3-black w3-xxxlarge w3-hover-aqua" action="https://github.com/PashaLysyi321/CSC-Hackathon-2021">
            <button class="w3-black w3-button w3-black w3-xxxlarge w3-hover-aqua" type="submit">Documentation</button>
        </form>
    </div>
	</body>
	</html>
	''' 



@app.route('/sort/', methods=['GET', 'POST']) 
def make_sorted_arhiv(): 
	if request.method == 'POST': 
		classes = [] 
		for key in request.form: 
			id_ = key.partition('.')[-1] 
			classes.append(request.form[key]) 
		images = []
		list_sorted_of_photo = os.listdir("input_images")
		for i in list_sorted_of_photo:
			print(i)
			im = Image.open("input_images/" + i).convert('RGB')
			image = torch.round(preprocess(im)).tolist()
			images.append(image)

		descriptions = {}

		for my_class in classes:
			descriptions[my_class] = "This is an image of " + str(my_class)

		texts = [descriptions[key] for key in descriptions]
		string_json = text_for_json(images,texts)

		input = json.loads(string_json)
		client = Algorithmia.client("simYKrM14fpua/WUk+v4SOYjzda1")
		algo = client.algo("NNNN4/ImageSortNet1/0.4.0")
		param_to_flask = algo.pipe(input).result.get('product')
		
		print(param_to_flask)
		
		os.makedirs('output_classes',exist_ok=True)
		for i in classes:
			os.makedirs('output_classes/'+i,exist_ok=True)
		for i in range(0,len(list_sorted_of_photo)):
			print('output_classes/'+str(classes[param_to_flask[i][0]])+'/'+str(list_sorted_of_photo[i]))
			os.replace("input_images/"+str(list_sorted_of_photo[i]), 'output_classes/'+str(classes[param_to_flask[i][0]])+'/'+str(list_sorted_of_photo[i]))


		def zipdir(path, ziph):
			# ziph is zipfile handle
			for root, dirs, files in os.walk(path):
				for file in files:
					ziph.write(os.path.join(root, file), 
							   os.path.relpath(os.path.join(root, file), 
											   os.path.join(path, '..')))

		zipf = zipfile.ZipFile('Python.zip', 'w', zipfile.ZIP_DEFLATED)
		zipdir('output_classes/', zipf)
		zipf.close()
		
		app.config['UPLOAD_FOLDER'] = "." 
		return send_from_directory(app.config['UPLOAD_FOLDER'], "Python.zip", as_attachment=True)
	return False

if __name__ == "__main__":
	app.run()
