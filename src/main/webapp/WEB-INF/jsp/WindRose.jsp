<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 判断页面有效性-->
<%
	Object uName = session.getAttribute("user");
	//判断用户是否登录
	if (uName == null) {
		//	session.setAttribute("errMsg", "你还没登录，请登录...");
		//重定向到登录页面
		//	response.sendRedirect("login");
	}
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<title>风玫瑰图</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
</head>
<body>
	<div>
		开始时间&nbsp;<input type="text" id="wrStartTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="wrEndTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp; 风机&nbsp; <select
			id="wrfanlist" style="vertical-align: middle;" name="name">
		</select> &nbsp;&nbsp;
		<button id="btn" type="button" onclick="wrSelect()"
			class="easyui-linkbutton" iconCls="icon-search">查询</button>
		&nbsp;&nbsp;
		<button id="csv" type="button" onclick="wrExporterExcel()"
			class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
	</div>
	<div style="width: 100%; height: 450px;">
		<table border="0" width="100%" height="100%" cellspacing="0"
			cellpadding="0">
			<td width="33%" height="100%" valign="middle" align="center">
				<div id="echarts1" style="width: 100%; height: 400px;"></div>
			</td>
			<td width="33%" height="100%" valign="middle" align="center">
				<div id="echarts2" style="width: 100%; height: 400px;"></div>
			</td>
			<td width="33%" height="100%" valign="middle" align="center">
				<div id="echarts3" style="width: 100%; height: 400px;"></div>
			</td>
		</table>
	</div>
	<div style="width: 100%">
		<table class="easyui-datagrid" id="windRoseList" title="功率曲线列表"
			style="width: auto;"
			data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'windDirection',width:60">风向区间</th>
					<th data-options="field:'avgWindSpeed',width:100">平均风速(m/s)</th>
					<th data-options="field:'windDirectionFrequency',width:100">风向频率(%)</th>
					<th data-options="field:'windEnergy',width:100">风能</th>
					<th data-options="field:'avgPower',width:100">平均功率(KW)</th>
					<th data-options="field:'frequency',width:100">频次</th>
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
	
		function wrJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
			//如果JSONData不是对象，那么JSON。parse将解析对象中的JSON字符串
			var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
				: JSONData;
			//           alert(arrData);
			var CSV = '';
			//在第一行或第一行设置报表标题
			CSV += ReportTitle + '\r\n\n';
			//此条件将生成标签/标头
			if (ShowLabel) {
				var row = "";
				//导出的标题
				row = "风向区间,平均风速(m/s),风向频率(%),风能,平均功率(KW),频次";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
	
			for (var i = 0; i < (arrData.rows.length); i++) {
				var row = "";
				row = arrData.rows[i].windDirection + "," + arrData.rows[i].avgWindSpeed + "," + arrData.rows[i].windDirectionFrequency + "," + arrData.rows[i].windEnergy + "," + arrData.rows[i].avgPower + "," + arrData.rows[i].frequency + ",";
	
				row.slice(0, row.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row + '\r\n';
			}
			if (CSV == '') {
				alert("无数据");
				return;
			}
			var fileName = "";
			fileName += ReportTitle.replace(/ /g, "_");
			var link = document.createElement("a");
			var blob = new Blob([ CSV ], {
				type : 'text/csv'
			});
			link.setAttribute("href", URL.createObjectURL(blob));
			link.style = "visibility:hidden";
			link.download = fileName + ".csv";
	
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		}
	
	
		//导出CSV 获取easyui 表格数据
		function wrExporterExcel() {
			//获取datagrid对象
			var dg = $("#windRoseList");
			//获取所有行
			var rowTmp = $('#windRoseList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			wrJSONToCSVConvertor(rowTmp, "风玫瑰图数据", true, true);
		}
	</script>

	<script type="text/javascript">
		//页面初始化,默认时间
		$(function() {
			//动态添加下拉列表	
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
	
						$("#wrfanlist").append("<option value='" + data[i].gid + "'>" + data[i].name + "</option>")
					}
					//获取当前日期的零点
					var st = $("#wrStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#wrEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#wrStartTime").val("2019-01-01 12:44:21");
					//var et = $("#wrEndTime").val("2019-01-20 12:44:21");
					//默认选中的风机value值
					var gid = data[0].gid;
					var stime = st.val();
					var etime = et.val();
					wrData(gid, stime, etime);
				}
			});
		});
	
		//点击查询按钮
		function wrSelect() {
			var gid = $("#wrfanlist").val();
			var stime = $("#wrStartTime").val();
			var etime = $("#wrEndTime").val();
			wrData(gid, stime, etime);
		}
		function wrData(gid, stime, etime) {
			if (gid == "" || "" == (gid + "")) {
				alert("请选择风机！");
			} else if ("" == stime || "" == etime || "" == (stime + "") || "" == (etime + "")) {
				alert("请输入日期！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else {
				//获取当前年
				var year = new Date().getFullYear();
				var stimeYear = stime.substring(0, 4);
				var etimeYear = etime.substring(0, 4);
				var yearCount = Number(etimeYear) - Number(stimeYear);
				if (etimeYear > year) {
					alert("您输入的年份不能超过当前年份！");
				} else if (yearCount > 1) {
					alert("查询时间过长！请缩短查询时间段！");
				} else {
					$.messager.progress({
						title : '提示',
						msg : '数据请求中，请稍候……',
						text : '努力中'
					});
					var myChart1 = echarts.init(document.getElementById('echarts1'));
					var myChart2 = echarts.init(document.getElementById('echarts2'));
					var myChart3 = echarts.init(document.getElementById('echarts3'));
					$(function() {
						$.ajax({
							url : 'WindRoseController/getWindRoseData',
							type : 'post',
							data : {
								"gid" : gid,
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								var avgWindSpeed = [];
								var windDirectionFrequency = [];
								var windEnergy = [];
								//$.messager.progress('close');
								$("#windRoseList").datagrid('loadData', result);
								for (var i = 0; i < result.length; i++) {
									avgWindSpeed.push(result[i].avgWindSpeed);
									windDirectionFrequency.push(result[i].windDirectionFrequency);
									windEnergy.push(result[i].windEnergy);
								}
								// 指定图表的配置项和数据
								var option1 = {
									tooltip : {
										trigger : 'item',
										textStyle : {
											fontSize : 16,
											color : '#fff',
											fontFamily : 'Microsoft YaHei'
										}
									},
									legend : {
										data : [ '平均风速' ],
										left : 'left',
										align : 'left'
									},
									polar : {
										center : [ '50%', '50%' ]
									},
									color : [ "#68CFE9" ],
									angleAxis : {
										splitNumber : 60, //坐标轴分割段数
										zlevel : 2,
										type : 'category',
										data : [
											{
												value : '北'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '东'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '南'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '西'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
										],
										boundaryGap : false, //标签和数据点都会在两个刻度之间的带(band)中间
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										show : true,
										splitLine : {
											show : true,
										},
										axisLabel : {
											show : true,
											interval : 1, //坐标轴刻度标签的显示间隔，在类目轴中有效
											textStyle : {
												color : '#000'
											}
										},
									},
									radiusAxis : {
										min : 0,
										// 										max : 50,
										axisLabel : {
											formatter : '{value}   ',
											margin : -16,
	
											textStyle : {
												fontSize : 10,
												color : 'black',
												padding : 3,
												width : 20,
												//backgroundColor : 'lightgray',
												//borderColor : 'black',
												//borderWidth : 1,
												fontFamily : 'Microsoft YaHei'
											},
											rich : { }
										},
	
										zlevel : 3,
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										axisLine : {
											show : false, //是否显示坐标轴轴线
										},
									},
									polar : {
									},
									series : [ {
										barCategoryGap : 0,
										type : 'bar',
	
										data : avgWindSpeed,
										coordinateSystem : 'polar',
										name : '平均风速',
										stack : 'a',
										itemStyle : {
											borderColor : '#68CFE9',
										}
									} ]
								};
	
	
								var option2 = {
									tooltip : {
										trigger : 'item',
										textStyle : {
											fontSize : 16,
											color : '#fff',
											fontFamily : 'Microsoft YaHei'
										}
									},
									legend : {
										data : [ '风向频率' ],
										left : 'left',
										align : 'left'
									},
									polar : {
										center : [ '50%', '50%' ]
									},
									color : [ "#68CFE9" ],
									angleAxis : {
										splitNumber : 60, //坐标轴分割段数
										zlevel : 2,
										type : 'category',
										data : [
											{
												value : '北'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '东'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '南'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '西'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
										],
										boundaryGap : false, //标签和数据点都会在两个刻度之间的带(band)中间
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										show : true,
										splitLine : {
											show : true,
										},
										axisLabel : {
											show : true,
											interval : 1, //坐标轴刻度标签的显示间隔，在类目轴中有效
											textStyle : {
												color : '#000'
											}
										},
									},
									radiusAxis : {
										min : 0,
										//max : 50,
										axisLabel : {
											formatter : '{value}   ',
											margin : -16,
	
											textStyle : {
												fontSize : 10,
												color : 'black',
												//padding : 3,
												width : 20,
												//backgroundColor : 'lightgray',
												//borderColor : 'black',
												//borderWidth : 1,
												fontFamily : 'Microsoft YaHei'
											},
											rich : { }
										},
	
										zlevel : 3,
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										axisLine : {
											show : false, //是否显示坐标轴轴线
										},
									},
									polar : {
									},
									series : [ {
										barCategoryGap : 0,
										type : 'bar',
	
										data : windDirectionFrequency,
										coordinateSystem : 'polar',
										name : '风向频率',
										stack : 'a',
										itemStyle : {
											borderColor : '#68CFE9',
										}
									} ]
								};
	
	
								var option3 = {
									tooltip : {
										trigger : 'item',
										textStyle : {
											fontSize : 16,
											color : '#fff',
											fontFamily : 'Microsoft YaHei'
										}
									},
									legend : {
										data : [ '风能' ],
										left : 'left',
										align : 'left'
									},
									polar : {
										center : [ '50%', '50%' ]
									},
									color : [ "#68CFE9" ],
									angleAxis : {
										splitNumber : 60, //坐标轴分割段数
										zlevel : 2,
										type : 'category',
										data : [
											{
												value : '北'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '东'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '南'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
											{
												value : '西'
											},
											{
												value : ''
											}, {
												value : ''
											}, {
												value : ''
											},
										// 											
										],
										boundaryGap : false, //标签和数据点都会在两个刻度之间的带(band)中间
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										show : true,
										splitLine : {
											show : true,
										},
										axisLabel : {
											show : true,
											interval : 1, //坐标轴刻度标签的显示间隔，在类目轴中有效
											textStyle : {
												color : '#000'
											}
										},
									},
									radiusAxis : {
										min : 0,
										//max : 50,
										axisLabel : {
											formatter : '{value}   ',
											margin : -16,
	
											textStyle : {
												fontSize : 10,
												color : 'black',
												padding : 3,
												width : 20,
												//backgroundColor : 'lightgray',
												//borderColor : 'black',
												//borderWidth : 1,
												fontFamily : 'Microsoft YaHei'
											},
											rich : { }
										},
	
										zlevel : 3,
										axisTick : {
											show : false //是否显示坐标轴刻度
										},
										axisLine : {
											show : false, //是否显示坐标轴轴线
										},
									},
									polar : {
									},
									series : [ {
										barCategoryGap : 0,
										type : 'bar',
	
										data : windEnergy,
										coordinateSystem : 'polar',
										name : '风能',
										stack : 'a',
										itemStyle : {
											borderColor : '#68CFE9',
										}
									}]
								};
								//清除画布缓存
								myChart1.clear();
								// 使用刚指定的配置项和数据显示图表。
								myChart1.setOption(option1);
								myChart2.clear();
								myChart2.setOption(option2);
								myChart3.clear();
								myChart3.setOption(option3);
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		}
	</script>
</body>
</html>
