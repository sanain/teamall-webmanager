(function(){ 
    //Section 1 : 按下自定义按钮时执行的代码 
    var a= { 
        exec:function(editor){ 
           alert("这是自定义按钮"); 
       } 
    }, 
    //Section 2 : 创建自定义按钮、绑定方法 
    b='multiplechoice'; 
    CKEDITOR.plugins.add(b,{ 
    	 requires: ['styles', 'button'],
         init: function (a) {
                 a.addCommand(b, CKEDITOR.plugins.selpic.commands.multiplechoice);
                 a.ui.addButton('multiplechoice', {
                        label: "多图选择",
                        command: 'multiplechoice',
                        icon: this.path + "check-icon.png"
            });

         } 
    }); 


 CKEDITOR.plugins.selpic = {
     commands: {
    	 multiplechoice: {
                exec: function (editor) {
                	editors=editor;
                	BrowseServer();
               }
         }

    }
};

})(); 

var editors;
function BrowseServer()
{
	var url = editors.config.ckfinderPath+"/ckfinder.html?type=images&start=images:"+editors.config.ckfinderUploadPath+"&action=js&func=imgSelectAction&thumbFunc=showThumbSelectAction&&dts=0&sm=1";
    windowOpen(url,"文件管理",1000,700);
}

function imgSelectAction(fileUrl, data, files)
{
    
	var url="";
	var imgs="<img alt='' src=''  />";
	for(var i=0; i<files.length; i++){
		url = files[i].url;
		imgs+= "<img alt='' src='"+url+"'  />";
	}
	editors.insertHtml(imgs);
}

function showThumbSelectAction(fileUrl, data, allFiles)
{
	var sFileName = this.getSelectedFile().name;
	document.getElementById( 'thumbnails' ).innerHTML +=
			'<div class="thumb">' +
				'<img src="' + fileUrl + '" />' +
				'<div class="caption">' +
					'<a href="' + data["fileUrl"] + '" target="_blank">' + sFileName + '</a> (' + data["fileSize"] + 'KB)' +
				'</div>' +
			'</div>';

	document.getElementById( 'preview' ).style.display = "";
	return false;
}
