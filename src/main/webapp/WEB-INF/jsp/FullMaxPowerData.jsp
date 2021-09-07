<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<title>功率详情（全场功率详情）</title>
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
	<div style="width: 100%; height: 30px;">
		开始时间&nbsp;<input type="text" id="fpdStartTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="fpdEndTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp; 		
			<button id="btn" type="button" onclick="fmpdSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="fmpdExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>
	</div>
	<div style="width: 100%; height: 35px;" align="center">
		<span id="fullmaxCurp"
			style="color: black; font-size:18px; font-weight: bold;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="fullmaxCurpWind"
			style="color: black; font-size:18px; font-weight: bold;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span id="fullmaxCurpTime"
			style="color: black; font-size:18px; font-weight: bold;"></span>
	</div>
	<div style="width: 100%,overflow:hidden">
		<table class="easyui-datagrid" id="FullMaxPowerSingleData"
			title="全场功率详情数据" style="width: auto;"
			data-options="singleSelect:false,collapsible:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'name',width:60">风机名称</th>
					<th data-options="field:'curp',width:60">功率(KW)</th>
					<th data-options="field:'savetime',width:60">时间</th>
					<th data-options="field:'windSpeed',width:60">风速(m/s)</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

	<script type="text/javascript">
		function fmpdJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
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
				row = "风机名称,功率（kW）,时间,风速（m/s）";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
			//第一个循环是提取每一行
			for (var i = 0; i < arrData.rows.length; i++) {
				var row = "";
	
	
				row = arrData.rows[i].name + "," + arrData.rows[i].curp + "," + arrData.rows[i].savetime + "," + arrData.rows[i].windSpeed + ",";
	
				row.slice(0, row.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row + '\r\n';
	
			}
			//           alert(CSV);
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
		function fmpdExporterExcel() {
			//获取datagrid对象
			var dg = $("#FullMaxPowerSingleData");
			//获取所有行
			var rowTmp = $('#FullMaxPowerSingleData').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			fmpdJSONToCSVConvertor(rowTmp, "全场功率详情数据", true);
		}
	</script>

	<script type="text/javascript">
		var savetime = "";
		function next() {
			if (savetime !== "") {
				$(function() {
					$.ajax({
						url : 'FullMaxPowerDataController/getFullMaxPowerSingleData',
						type : 'post',
						data : {
							"savetime" : savetime
						}, //向后台传参
						datatype : 'json',
						success : function(result) {
							$("#FullMaxPowerSingleData").datagrid('loadData', result);
						}
					})
				});
			}
		}
	
		//页面初始化,默认时间
		$(function() {
			//获取当前日期的零点
			var st = $("#fpdStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
			//获取当前时间
			var et = $("#fpdEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
// 			var st = $("#fpdStartTime").val("2019-01-01 12:44:21");
// 			var et = $("#fpdEndTime").val("2019-01-02 12:44:21");
			var stime = st.val();
			var etime = et.val();
// 			fmpdData(stime, etime);
		})
		function fmpdSelect() {
			var stime = $("#fpdStartTime").val();
			var etime = $("#fpdEndTime").val();
			fmpdData(stime, etime);
		}
		function fmpdData(stime, etime) {
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
					$(function() {
						$.ajax({
							url : 'FullMaxPowerDataController/getFullMaxPowerData',
							type : 'post',
							data : {
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								savetime = result.fullmaxCurpTime;
								//$("#fullmaxCurp").empty();
								$("#fullmaxCurp").text("全场最大有功功率：" + result.fullmaxCurp + "KW");
								//$("#fullmaxCurpWind").empty();
								$("#fullmaxCurpWind").text("风速：" + result.fullmaxCurpWind + "m/s");
								//$("#fullmaxCurpTime").empty();
								$("#fullmaxCurpTime").text("时间：" + result.fullmaxCurpTime);
								 next();
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

