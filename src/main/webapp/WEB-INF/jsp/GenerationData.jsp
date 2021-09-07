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

<title>发电量</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="easyui/js/datagrid-export.js"></script>
</head>
<body>
	<div>
		开始时间&nbsp;<input type="text" id="gdStartTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="gdEndTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;
		<button id="btn" type="button" onclick="gdSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="gdExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>

	</div>
	<div id="gdmain" style="width: 100%; height: 400px;"></div>
	<div style="width: 100%">
		<table class="easyui-datagrid" id="getGenerationData" title="风机发电列表"
			style="width: auto;"
			data-options="singleSelect:false,collapsible:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
<!-- 			    <th data-options="field:'id',width:20">风机id</th> -->
					<th data-options="field:'name',width:60">风机名称</th>
					<th data-options="field:'genwh',width:100">发电量(MWh)</th>
					<th data-options="field:'genHour',width:100">发电时间(h)</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		//获取当前时间，格式YYYY-MM-DD
		function gdJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel,removeLabel) {
			//如果JSONData不是对象，那么JSON。parse将解析对象中的JSON字符串
			var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
				: JSONData;
			//alert(arrData);
			var CSV = '';
			//在第一行或第一行设置报表标题
			CSV += ReportTitle + '\r\n\n';
			//此条件将生成标签/标头
			if (ShowLabel) {
				var row = "";
				//导出的标题
				row = "风机名称,发电量(MWh),发电时间(h)";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
			//第一个循环是提取每一行
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].genwh + "," + arrData.rows[i].genHour + ",";
					CSV += row + '\r\n';
				}
	
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].genwh + "," + arrData.rows[i].genHour + ",";
					CSV += row + '\r\n';
				}
			}
			if (CSV == '') {
				alert("无数据");
				return;
			}
			//Generate a file name
	
			// 　　　//这里我使用了当前时间用来为导出的文件命名
			var fileName = "";
			fileName += ReportTitle.replace(/ /g, "_");
	
			var link = document.createElement("a");
			//           var debug = {hello: CSV};
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
		function gdExporterExcel() {
			//获取datagrid对象
			var dg = $("#getGenerationData");
			//获取所有行
			var rowTmp = $('#getGenerationData').datagrid('getData');
			if (rowTmp == '')
				return;
			gdJSONToCSVConvertor(rowTmp, "发电量", true,false);
		}
// 		function gdExporterExcel() {
// 			//获取datagrid对象
// 			var dg = $("#getGenerationData");
// 			//获取所有行
// 			var rowTmp = $('#getGenerationData').datagrid('getData');
// 			if (rowTmp == '')
// 				return;
// 			gdJSONToCSVConvertor(rowTmp, "发电量", true,true);
// // 			alert("1");
// 			gdJSONToCSVConvertor(rowTmp, "发电量", true,false);
// // 			alert("2");
// 			gdJSONToCSVConvertor(rowTmp, "发电量", false,true);
// // 			alert("3");
// 			gdJSONToCSVConvertor(rowTmp, "发电量", false,false);
// // 			alert("4");
			
// 		}
		
		
	</script>
	<script type="text/javascript">
	
		//页面初始化,默认时间
		$(function() {
			//获取当前日期的零点
			//var et = $("#gdEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
			var st = $("#gdStartTime").val(new Date().format('yyyy-MM-dd 00:00:01'));
//			var st = $("#gdStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
			//alert(new Date().toLocaleDateString())	;
			//alert(new Date(new Date().toLocaleDateString()).getTime())	;
			//alert(st)	;
			
			//获取当前时间
			var et = $("#gdEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
			//var st = $("#gdStartTime").val("2019-01-01 12:44:21");
			//var et = $("#gdEndTime").val("2019-01-02 12:44:21");
			var stime = st.val();
			var etime = et.val();
			gdData(stime, etime);
		})
		function gdSelect() {
			var stime = $("#gdStartTime").val();
			var etime = $("#gdEndTime").val();
			gdData(stime, etime);
		}
		function gdData(stime, etime) {
			if (stime == "" || etime == "") {
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
					//数据加载时显示加载提示框
					$.messager.progress({
						title : '提示',
						msg : '数据请求中，请稍候……',
						text : ''
					});
					var myChart = echarts.init(document.getElementById('gdmain'));
					$(function() {
						$.ajax({
							url : 'generationDataController/getGenerationData',
							type : 'post',
							data : {
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								var name = [];
								var value = [];
								for (var i = 0; i < result.length; i++) {
									name.push(result[i].name);
									value.push(result[i].genwh);
								}
								$("#getGenerationData").datagrid('loadData', result);
								// 指定图表的配置项和数据
								var option = {
									title : {
										text : '',
									},
									tooltip : {
										trigger : 'axis' //坐标轴触发
									},
									grid : {
										left : '5%',
										right : '5%'
									},
								/* 	legend : {
										data : [ '发电量' ],
										//left : 'right',
										//align : 'left'
									}, */
									xAxis : {
										type : 'category',
										name : '风机',
										data : name
									},
									yAxis : [
										//第一个Y轴坐标
										{
											type : 'value',
											name : '发电量',
											axisLabel : {
												formatter : '{value}' //控制输出格式
											}
										}
									],
									series : [ {
										name : '发电量',
										type : 'bar',
										itemStyle : {
											normal : {
												color : '#68CFE9', //曲线颜色
											}
										},
										data : value
									}
									]
								};
								//清除画布缓存
								myChart.clear();
								// 使用刚指定的配置项和数据显示图表
								myChart.setOption(option);
								gdSumData();
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
	
					});
				}
			}
		}
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function gdSumData() { //计算函数
			var rows = $('#getGenerationData').datagrid('getRows'); //获取当前的数据行
			var genwhNum = 0; //发电量的总和赋初始值
			var genHourNum = 0; //发电小时数的总和赋初始值		
			for (var i = 0; i < rows.length; i++) {
				genwhNum += rows[i]['genwh'];
				genHourNum += rows[i]['genHour'];
			}
			genwhNum = genwhNum.toFixed(3);
			genHourNum = (genHourNum / rows.length).toFixed(3);
			//新增一行显示统计信息
			$('#getGenerationData').datagrid('appendRow', {
				name : '综合计算',
				genwh : '发电量总和：' + genwhNum,
				genHour : '平均发电时间：' + genHourNum,
			});
		}
	</script>
</body>
</html>
