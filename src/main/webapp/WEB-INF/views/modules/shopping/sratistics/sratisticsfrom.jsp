<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
	<meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
	<title>销售信息</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script type="text/javascript">
        $(function(){
            sratisticsdayorder();
            sratisticsdayorderzh();
            sratisticsdayorderclick();
            sratisticsorderbyuserregiter();
            sratisticsbyuserregiter();
            sratisticsbyordermap();
            sratisticsbyorderdevice();
            sratisticsbyordernotwholesale();
            sratisticsbyorderwholesale();
            sratisticsbyopenapp();
            sratisticsbyregiteruser();
            sratisticsbyregiteruseravg();
            sratisticsorderitembyproduct('.tbody_html_12',1);
            <c:if test="${fns:isShowWeight()}">
            sratisticsorderitembyproduct('.tbody_html_15',2);
            // sratisticsorderitembyproduct('.tbody_html_17',4);
			</c:if>
            // sratisticsorderitembyproduct('.tbody_html_16',3);
            sratisticsorderitembyproperty();
            sratisticsorderitembyproductsum();
        });
	</script>

	<script type="text/javascript">
        function sratisticsorderitembyproductsum(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsorderitembyproductsum",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        for(var i=0,l=data.sratisticsOrderitemByProductSum.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.sratisticsOrderitemByProductSum[i][0]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderitemByProductSum[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderitemByProductSum[i][2]+'</b></td>'
                                +'</tr>';
                        }
                        $('.tbody_html_14').html($('.tbody_html_14').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsorderitembyproperty(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsorderitembyproperty",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        for(var i=0,l=data.sratisticsOrderItemByPropertyList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.sratisticsOrderItemByPropertyList[i][0]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderItemByPropertyList[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderItemByPropertyList[i][2]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderItemByPropertyList[i][3]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderItemByPropertyList[i][4]+'</b></td>'
                                +'</tr>';
                        }
                        $('.tbody_html_13').html($('.tbody_html_13').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>

	<script type="text/javascript">
        function sratisticsorderitembyproduct(element,type){
            debugger;
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsorderitembyproduct",
                type : "post",
                data : {
                    type:type
                },
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        if(data.sratisticsOrderItemByProductList.length == 0){
                            ht=ht+'<tr class="table_minor"><td colspan="3" style="text-align: center">暂无数据</td></tr>'
                        }else{
                            //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                            for(var i=0,l=data.sratisticsOrderItemByProductList.length;i<l;i++){
                                ht=ht+'<tr class="table_minor">'
                                    +'<td width="91"><b>'+data.sratisticsOrderItemByProductList[i][0]+'</b></td>'
                                    +'<td width="91"><b>'+data.sratisticsOrderItemByProductList[i][1]+'</b></td>'
                                    +'<td width="91"><b>'+data.sratisticsOrderItemByProductList[i][2]+'</b></td>'
                                    +'</tr>';
                            }
                        }
                        $(element).html($(element).html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>

	<script type="text/javascript">
        function sratisticsbyregiteruseravg(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyregiteruseravg",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        for(var i=0,l=data.sratisticsbyregiteruserAvgList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.sratisticsbyregiteruserAvgList[i][0]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsbyregiteruserAvgList[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsbyregiteruserAvgList[i][2]+'</b></td>'
                                +'</tr>';
                        }
                        $('.tbody_html_11').html($('.tbody_html_11').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyregiteruser(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyregiteruser",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        for(var i=0,l=data.sratisticsbyregiteruserList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="182"><b>'+data.sratisticsbyregiteruserList[i][0]+'</b></td>'
                                +'<td width="201"><b>'+data.sratisticsbyregiteruserList[i][1]+'</b></td>'
                                +'</tr>';
                        }
                        $('.tbody_html_10').html($('.tbody_html_10').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyopenapp(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyopenapp",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        for(var i=0,l=data.ebConversionlist.length;i<l;i++){
                            if(i!=0){
                                ht=ht+'<tr class="table_minor">'
                                    +'<td width="91"><b>'+data.ebConversionlist[i][0]+'</b></td>'
                                    +'<td width="91"><b>'+data.ebConversionlist[i][2]+'</b></td>'
                                    +'<td width="201"><b>'+(data.ebConversionlist[i-1][2]==0?0:(data.ebConversionlist[i][2]-data.ebConversionlist[i-1][2]/data.ebConversionlist[i][2]))+'</b></td>'
                                    +'</tr>';
                                //}
                            }
                        }
                        $('.tbody_html_9').html($('.tbody_html_9').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyorderdevice(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyorderdevice",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.sratisticsOrderByUserAreaList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+(data.sratisticsOrderByUserAreaList[i][0]==1?'自主':'其他')+'</b></td>'
                                +'<td width="201"><b>'+(data.sratisticsOrderByUserAreaList[i][1]==1?'android':(data.sratisticsOrderByUserAreaList[i][1]==2?'IOS':data.sratisticsOrderByUserAreaList[i][1]==3?'H5':"其他"))+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderByUserAreaList[i][2]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_6').html($('.tbody_html_6').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyordernotwholesale(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyordernotwholesale",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.SratisticsOrderNotWholesaleList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+(data.SratisticsOrderNotWholesaleList[i][0])+'</b></td>'
                                +'<td width="70"><b>'+(data.SratisticsOrderNotWholesaleList[i][1])+'</b></td>'
                                +'<td width="76"><b>'+data.SratisticsOrderNotWholesaleList[i][2]+'</b></td>'
                                +'<td width="73"><b>'+data.SratisticsOrderNotWholesaleList[i][3]+'</b></td>'
                                +'<td width="73"><b>'+data.SratisticsOrderNotWholesaleList[i][4]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_7').html($('.tbody_html_7').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyorderwholesale(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyorderwholesale",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.SratisticsOrderWholesaleList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+(data.SratisticsOrderWholesaleList[i][0])+'</b></td>'
                                +'<td width="70"><b>'+(data.SratisticsOrderWholesaleList[i][1])+'</b></td>'
                                +'<td width="76"><b>'+data.SratisticsOrderWholesaleList[i][2]+'</b></td>'
                                +'<td width="73"><b>'+data.SratisticsOrderWholesaleList[i][3]+'</b></td>'
                                +'<td width="73"><b>'+data.SratisticsOrderWholesaleList[i][4]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_8').html($('.tbody_html_8').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsbyordermap(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyordermap",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.sratisticsOrderByUserAreaList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.sratisticsOrderByUserAreaList[i][0]+'</b></td>'
                                +'<td width="201"><b>'+data.sratisticsOrderByUserAreaList[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderByUserAreaList[i][2]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_5').html($('.tbody_html_5').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>

	<script type="text/javascript">
        function sratisticsbyuserregiter(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsbyuserregiter",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.getSratisticsByUserRegiterList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.getSratisticsByUserRegiterList[i][0]+'</b></td>'
                                +'<td width="201"><b>'+data.getSratisticsByUserRegiterList[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.getSratisticsByUserRegiterList[i][2]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_4').html($('.tbody_html_4').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsorderbyuserregiter(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsorderbyuserregiter",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.sratisticsOrderByUserRegiterList.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.sratisticsOrderByUserRegiterList[i][0]+'</b></td>'
                                +'<td width="201"><b>'+data.sratisticsOrderByUserRegiterList[i][1]+'</b></td>'
                                +'<td width="91"><b>'+data.sratisticsOrderByUserRegiterList[i][2]+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_3').html($('.tbody_html_3').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>

	<script type="text/javascript">
        function sratisticsdayorderclick(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsdayorderclick",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.liHashMaps.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.liHashMaps[i]['createDate']+'</b></td>'
                                +'<td width="201"><b>'+data.liHashMaps[i]['ebBannerClickName']+'</b></td>'
                                +'<td width="91"><b>'+data.liHashMaps[i]['ebBannerClickCount']+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html_2').html($('.tbody_html_2').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>

	<script type="text/javascript">
        function sratisticsdayorder(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsdayorder",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        var ht="";
                        for(var i=0,l=data.orderList.length;i<l;i++){
                            //for(var key in data.orderList[i]){
                            //alert(key+':'+data[i][key]);
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.orderList[i]['daytime']+'</b></td>'
                                +'<td width="91"><b>'+data.orderList[i]['orderCount']+'</b></td>'
                                +'<td width="201"><b>'+data.orderList[i]['orderHb']+'</b></td>'
                                +'</tr>';
                            //}
                        }
                        $('.tbody_html').html($('.tbody_html').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
	<script type="text/javascript">
        function sratisticsdayorderzh(){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsdayorderzh",
                type : "post",
                cache : false,
                success : function(data) {
                    console.log(data.code);
                    if(data.code=='00'){
                        //类型：1首页，2商品列表页，3详情页，4支付页，5支付成功 6确认订单
                        //转换率 ：（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数
                        var ht='';
                        for(var i=0,l=data.liHashMaps.length;i<l;i++){
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.list[i]+'</b></td>'
                                +'<td width="111"><b>'+data.liHashMaps[i].ebConversion_1['conversionTypeName']+'-'+data.liHashMaps[i].ebConversion_2['conversionTypeName']+'('+data.liHashMaps[i].ebConversion_1['conversionCount']+'-'+data.liHashMaps[i].ebConversion_2['conversionCount']+')'+'</b></td>'
                                +'<td width="181"><b>'+(data.liHashMaps[i].ebConversion_2['conversionCount']==0?0:(data.liHashMaps[i].ebConversion_1['conversionCount']-data.liHashMaps[i].ebConversion_2['conversionCount'])/data.liHashMaps[i].ebConversion_1['conversionCount'])+'</b></td>'
                                +'</tr>';
                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.list[i]+'</b></td>'
                                +'<td width="111"><b>'+data.liHashMaps[i].ebConversion_2['conversionTypeName']+'-'+data.liHashMaps[i].ebConversion_3['conversionTypeName']+'('+data.liHashMaps[i].ebConversion_2['conversionCount']+'-'+data.liHashMaps[i].ebConversion_3['conversionCount']+')'+'</b></td>'
                                +'<td width="181"><b>'+(data.liHashMaps[i].ebConversion_3['conversionCount']==0?0:(data.liHashMaps[i].ebConversion_2['conversionCount']-data.liHashMaps[i].ebConversion_3['conversionCount'])/data.liHashMaps[i].ebConversion_2['conversionCount'])+'</b></td>'
                                +'</tr>';

                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.list[i]+'</b></td>'
                                +'<td width="111"><b>'+data.liHashMaps[i].ebConversion_3['conversionTypeName']+'-'+data.liHashMaps[i].ebConversion_4['conversionTypeName']+'('+data.liHashMaps[i].ebConversion_3['conversionCount']+'-'+data.liHashMaps[i].ebConversion_4['conversionCount']+')'+'</b></td>'
                                +'<td width="181"><b>'+(data.liHashMaps[i].ebConversion_4['conversionCount']==0?0:(data.liHashMaps[i].ebConversion_3['conversionCount']-data.liHashMaps[i].ebConversion_4['conversionCount'])/data.liHashMaps[i].ebConversion_3['conversionCount'])+'</b></td>'
                                +'</tr>';

                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.list[i]+'</b></td>'
                                +'<td width="111"><b>'+data.liHashMaps[i].ebConversion_4['conversionTypeName']+'-'+data.liHashMaps[i].ebConversion_5['conversionTypeName']+'('+data.liHashMaps[i].ebConversion_4['conversionCount']+'-'+data.liHashMaps[i].ebConversion_5['conversionCount']+')'+'</b></td>'
                                +'<td width="181"><b>'+(data.liHashMaps[i].ebConversion_5['conversionCount']==0?0:(data.liHashMaps[i].ebConversion_4['conversionCount']-data.liHashMaps[i].ebConversion_5['conversionCount'])/data.liHashMaps[i].ebConversion_4['conversionCount'])+'</b></td>'
                                +'</tr>';

                            ht=ht+'<tr class="table_minor">'
                                +'<td width="91"><b>'+data.list[i]+'</b></td>'
                                +'<td width="111"><b>'+data.liHashMaps[i].ebConversion_6['conversionTypeName']+'-'+data.liHashMaps[i].ebConversion_5['conversionTypeName']+'('+data.liHashMaps[i].ebConversion_6['conversionCount']+'-'+data.liHashMaps[i].ebConversion_5['conversionCount']+')'+'</b></td>'
                                +'<td width="181"><b>'+(data.liHashMaps[i].ebConversion_5['conversionCount']==0?0:(data.liHashMaps[i].ebConversion_6['conversionCount']-data.liHashMaps[i].ebConversion_5['conversionCount'])/data.liHashMaps[i].ebConversion_6['conversionCount'])+'</b></td>'
                                +'</tr>';
                        }
                        $('.tbody_html_1').html($('.tbody_html_1').html()+ht);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
</head>
<body>
<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
	<tbody>
	<tr>

		<td>
			<table style="width: 100%; height: 500px; border-right-color: rgb(102, 102, 102); border-bottom-color: rgb(102, 102, 102); border-left-color: rgb(102, 102, 102); border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: solid;" border="0" cellspacing="0" cellpadding="0">
				<tbody><tr><td valign="top" style="background: rgb(255, 255, 255);">

					<table id="pane615D9AA2E653CF843EFA3A724F5593B5" style="width: 100%;" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td style="background: rgb(255, 255, 255);">


						<br><br>
						<link href="../../css/style.css" rel="stylesheet" type="text/css">
						<table width="98%" align="center" cellspacing="1" cellpadding="3">
							<tbody>
							<tr>
								<td width="43%" align="center" valign="top">
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="2"><b>本周订单交易概况:${thisWeekMonday} 至今</b></td>
										</tr>
										<tr class="table_main">
											<td width="141"><b>本周订单总量</b></td>
											<td width="282"><font color="blue"><strong>${orderCount}</strong></font></td>
										</tr>
										<tr class="table_minor">
											<td width="141"><b>本周支付订单总量</b></td>
											<td width="282"><font color="blue"><strong>${payOrderCount}</strong></font></td>
										</tr>
										<tr class="table_main">
											<td width="141"><b>本周取消订单总量</b></td>
											<td width="282"><font color="blue"><strong>${closeOrderCount}</strong></font></td>
										</tr>
										<tr class="table_minor">
											<td width="141"><b>本周申请退款订单量</b></td>
											<td width="282"><font color="blue"><strong>${afterSaleCount}</strong></font></td>
										</tr>

										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>每日订单及环比情况</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>时间</b></td>
											<td width="91"><b>新增订单量</b></td>
											<td width="201"><b>环比增长率<font size="0.5">(环比增长率=（本期数-上期数）/上期数×100%)</font></b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_2"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>首页各栏目点击量</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>时间</b></td>
											<td width="201"><b>栏目名字</b></td>
											<td width="91"><b>点击量</b></td>
										</tr>


										</tbody>
									</table>
								</td>
								<td width="57%" align="center" valign="top">
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_1"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>各节点转化率分析</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>时间</b></td>
											<td width="91"><b>类型</b></td>
											<td width="201"><b>转化率<font size="0.5">(转换率=（上一个环节参与人数-下一个环节参与人数）/上一个环节参与人数)</font></b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_3"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>不同来源注册用户订单转化量</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>注册类型</b></td>
											<td width="201"><b>注册名字</b></td>
											<td width="91"><b>订单转化量</b></td>
										</tr>


										</tbody>
									</table>

									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_4"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>不同来源注册用户量</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>注册类型</b></td>
											<td width="201"><b>注册名字</b></td>
											<td width="91"><b>注册数量</b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_5"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>本周新增订单分布（地图）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>区域编码</b></td>
											<td width="201"><b>区域名字</b></td>
											<td width="91"><b>订单数量</b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_6"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>各终端订单量（柱状）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>营销类型</b></td>
											<td width="201"><b>终端名字</b></td>
											<td width="91"><b>订单数量</b></td>
										</tr>


										</tbody>
									</table>

									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_7"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>商品订单价格图标（表格）（非批发）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>日期</b></td>
											<td width="70"><b>订单数量</b></td>
											<td width="76"><b>总金额</b></td>
											<td width="73"><b>订单均价</b></td>
											<td width="73"><b>订单均让利额</b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_8"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>商品订单价格图标（表格）（批发）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>日期</b></td>
											<td width="70"><b>订单数量</b></td>
											<td width="76"><b>总金额</b></td>
											<td width="73"><b>订单均价</b></td>
											<td width="73"><b>订单均让利额</b></td>
										</tr>


										</tbody>
									</table>

									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_8"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>商品订单价格图标（表格）（批发）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>日期</b></td>
											<td width="70"><b>订单数量</b></td>
											<td width="76"><b>总金额</b></td>
											<td width="73"><b>订单均价</b></td>
											<td width="73"><b>订单均让利额</b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_9"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>过去一周全站日均启动次数<font size="0.5">(环比增长率=（本期数-上期数）/上期数×100%)</font></b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>日期</b></td>
											<td width="91"><b>启动次数</b></td>
											<td width="201"><b>环比增长率</b></td>
										</tr>


										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_10"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>过去一周每日注册用户数</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>日期</b></td>
											<td width="91"><b>注册次数</b></td>
										</tr>
										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_11"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>过去一周日均注册用户数</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>开始日期</b></td>
											<td width="91"><b>结束日期</b></td>
											<td width="91"><b>平均注册次数</b></td>
										</tr>
										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_12"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>Spu数（计量类型：件）（商品总数量 多规格只算一个）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>商品id</b></td>
											<td width="91"><b>商品名字</b></td>
											<td width="91"><b>销售数量</b></td>
										</tr>
										</tbody>
									</table>
									<c:if test="${fns:isShowWeight()}">
										<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
											<tbody class="tbody_html_15"><tr class="table_minor" style="background-color:#13f9cb">
												<td colspan="3"><b>Spu数（计量类型：重量，计量单位：公斤）（商品总数量 多规格只算一个）</b></td>
											</tr>
											<tr class="table_main">
												<td width="91"><b>商品id</b></td>
												<td width="91"><b>商品名字</b></td>
												<td width="91"><b>销售数量</b></td>
											</tr>
											</tbody>
										</table>
										<%--<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">--%>
											<%--<tbody class="tbody_html_17"><tr class="table_minor" style="background-color:#13f9cb">--%>
												<%--<td colspan="3"><b>Spu数（计量类型：重量，计量单位：斤）（商品总数量 多规格只算一个）</b></td>--%>
											<%--</tr>--%>
											<%--<tr class="table_main">--%>
												<%--<td width="91"><b>商品id</b></td>--%>
												<%--<td width="91"><b>商品名字</b></td>--%>
												<%--<td width="91"><b>销售数量</b></td>--%>
											<%--</tr>--%>
											<%--</tbody>--%>
										<%--</table>--%>
									<%--<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">--%>
										<%--<tbody class="tbody_html_16"><tr class="table_minor" style="background-color:#13f9cb">--%>
											<%--<td colspan="3"><b>Spu数（计量类型：重量，计量单位：克）（商品总数量 多规格只算一个）</b></td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
											<%--<td width="91"><b>商品id</b></td>--%>
											<%--<td width="91"><b>商品名字</b></td>--%>
											<%--<td width="91"><b>销售数量</b></td>--%>
										<%--</tr>--%>
										<%--</tbody>--%>
									<%--</table>--%>
									</c:if>
									<%--<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">--%>
									<%--<tbody class="tbody_html_12"><tr class="table_minor" style="background-color:#13f9cb">--%>
									<%--<td colspan="3"><b>Spu数（计量单位：件）（商品总数量 多规格只算一个）</b></td>--%>
									<%--</tr>--%>
									<%--<tr class="table_main">--%>
									<%--<td width="91"><b>商品id</b></td>--%>
									<%--<td width="91"><b>商品名字</b></td>--%>
									<%--<td width="91"><b>销售数量</b></td>--%>
									<%--</tr>--%>
									<%--</tbody>--%>
									<%--</table>--%>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_13"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b> Sku数（商品总数量  多规格每个规格算一个）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>商品id</b></td>
											<td width="91"><b>商品名字</b></td>
											<td width="91"><b>规格id</b></td>
											<td width="91"><b>规格名字</b></td>
											<td width="91"><b>销售数量</b></td>
										</tr>
										</tbody>
									</table>
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody class="tbody_html_14"><tr class="table_minor" style="background-color:#13f9cb">
											<td colspan="3"><b>过去一周全站商品销售总量 （数字）</b></td>
										</tr>
										<tr class="table_main">
											<td width="91"><b>开始日期</b></td>
											<td width="91"><b>结束日期</b></td>
											<td width="91"><b>销售总量</b></td>
										</tr>
										</tbody>
									</table>
								</td>
							</tr>
							</tbody></table>


						<br><br>
					</td>
					</tr>
					</tbody></table><br><br>

				</td></tr></tbody></table>


			<table id="pane615D9AB2E96F4F5E012C6741970CF57E" style="width: 100%; display: none;" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td style="background: rgb(255, 255, 255);">


				<br><br>
				<link href="../../css/style.css" rel="stylesheet" type="text/css">
				<br>




			</td></tr></tbody></table></td></tr></tbody></table>
</div>

</body>
</html>