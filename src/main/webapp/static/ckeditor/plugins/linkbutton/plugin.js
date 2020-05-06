(function(){ 
    //Section 1 : 按下自定义按钮时执行的代码 
    var a= { 
        exec:function(editor){ 
           alert("这是自定义按钮"); 
       } 
    }, 
    //Section 2 : 创建自定义按钮、绑定方法 
    b='linkbutton'; 
    CKEDITOR.plugins.add(b,{ 
        init:function(editor){ 
        	CKEDITOR.dialog.add('datepicker',this.path + "dialogs/datepicker.js"); 
        	editor.addCommand( 'linkbutton', new CKEDITOR.dialogCommand( 'datepicker' ));
            //editor.addCommand(b,a); 
            editor.ui.addButton('linkbutton',{ 
                label:'插入卡片', 
                icon: this.path + 'logo_ckeditor.png', 
                command:b 
            });
        } 
    }); 
})(); 
