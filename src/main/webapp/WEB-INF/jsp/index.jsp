<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>许继风电监控分析系统</title>
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script> 
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="js/echarts.min.js"></script>
<style type="text/css">
	.content {
		padding: 10px 10px 10px 10px;
	}
</style>
</head>
<body class="easyui-layout" >
    <!-- 头部标题 -->
	<div region="north" split="true" border="false"
		style="overflow: hidden; height: 45px; background: #7f99be; line-height: 38px; color: #fff; font-family: Verdana, 微软雅黑, 黑体">
		<span style="float: right; padding-right: 20px;" class="head"><span
			style="color: red; font-weight: bold;">${user.USER_ID}&nbsp;</span>您好&nbsp;&nbsp;&nbsp;<a
			href="login_out" id="loginOut">安全退出</a></span> 
			<span style="padding-left: 10px; font-size: 20px; font-weight:bold;">许继风电监控分析系统</span>
	</div>
    <div data-options="region:'west',title:'菜单',split:true" style="width:180px;">
    	<ul id="menu" class="easyui-tree" style="margin-top: 10px;margin-left: 5px;">
         	<li>
         		<span>运行统计</span>
         		<ul>
	         		<li data-options="attributes:{'url':'GenerationData'}">发电量</li>
	         		<li data-options="attributes:{'url':'PowerCurve'}">功率曲线</li>
	         		<li data-options="attributes:{'url':'FullMaxPowerData'}">全场功率详情</li>
	         		<li data-options="attributes:{'url':'SingleMaxPowerData'}">风机功率详情</li>
	         		<li data-options="attributes:{'url':'Availability'}">风机可利用率</li>
	         		<li data-options="attributes:{'url':'EffectiveHours'}">风机有效小时数</li>
	         		<li data-options="attributes:{'url':'FailureNumber'}">故障次数</li>	
	         	</ul>
         	</li>
         	<li>
         		<span>风况统计</span>
         		<ul>
	         		<li data-options="attributes:{'url':'WindSpeed'}">风速统计</li>
	         		<li data-options="attributes:{'url':'ScatterWindPower'}">风功率散点图</li>
	         		<li data-options="attributes:{'url':'WindRose'}">玫瑰图</li>
	         	</ul>
         	</li>
         	<li>
         		<span>历史查询</span>
         		<ul>
	         		<li data-options="attributes:{'url':'EquipmentFailure'}">风机故障查询</li>
	         		<li>
	         			<span>运行数据查询</span>
         				<ul>
	         				<li data-options="attributes:{'url':'HisImportantMeasure'}">重要量测信息</li>
	         				<li data-options="attributes:{'url':'HisMeasureInfo'}">量测信息</li>
	         				<li data-options="attributes:{'url':'HisStatisticalInfo'}">统计信息</li>
	         			</ul>
	         		</li>
	         		<li data-options="attributes:{'url':'OperatRecord'}">操作记录查询</li>
	         	</ul>
         	</li>
         	<li>
         		<span>报表统计</span>
         		<ul>
	         		<li data-options="attributes:{'url':'Report'}">报表</li>
	         		<li data-options="attributes:{'url':'ReportDay'}">日报表</li>
	         		<li data-options="attributes:{'url':'ReportMonth'}">月报表</li>
	         		<li data-options="attributes:{'url':'ReportYear'}">年报表</li>
	         		<li>
	         			<span>遥测报表</span>
         				<ul>
	         				<li data-options="attributes:{'url':'ReportYCImportantMeasure'}">遥测重要量测信息</li>
	         				<li data-options="attributes:{'url':'ReportYCMeasureInfo'}">遥测量测信息</li>
	         				<li data-options="attributes:{'url':'ReportYCStatisticalInfo'}">遥测统计信息</li>
	         			</ul>
	         		</li>
	         		<li data-options="attributes:{'url':'ReportFanState'}">风机状态统计报表</li>
	         		<li data-options="attributes:{'url':'ReportLossEle'}">损失电量报表</li>
	         	</ul>
         	</li>
         </ul>
    </div>
    <div id="mainPanle" region="center"
		style="background: #eee; overflow: hidden">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<jsp:include page="welcome.jsp" />
		</div>
	</div>
    <!-- 页脚信息 -->
	<div data-options="region:'south',border:false" style="height:20px; background:#D2E0F2; padding:2px; vertical-align:middle;">
		<span id="sysVersion">系统版本：V1.0</span>
	    <span id="nowTime"></span>
	</div>
<script type="text/javascript">
$(function(){
	$('#menu').tree({
		onClick: function(node){
			if($('#menu').tree("isLeaf",node.target)){
				var tabs = $("#tabs");
				var tab = tabs.tabs("getTab",node.text);
				if(tab){
					tabs.tabs("select",node.text);
				}else{
					tabs.tabs('add',{
					    title:node.text,
					    href: node.attributes.url,
					    closable:true,
					    bodyCls:"content"
					});
				}
			}
		}
	});
});
setInterval("document.getElementById('nowTime').innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
</script>
</body>
</html>