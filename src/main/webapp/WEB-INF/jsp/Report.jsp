<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<title>报表</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<!-- <link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" /> -->
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
</head>
<body>
	<div style="width: 100%;height:30px">
		开始时间&nbsp;<input type="text" id="rtStartTime" name="startTime"
			class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="rtEndTime" name="endTime"
			class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="btn" type="button" onclick="rtSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="rtExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>

	</div>
	<div style="width: 100%;">
		<table class="easyui-datagrid" id="reportList" title="风机报表"
			style="width: auto;"
			data-options="singleSelect:false,fitColumns:true,striped:true,method:'get',showFooter: true">
			<thead>
				<tr>
					<th data-options="field:'name',width:60">风机名称</th>
					<th data-options="field:'maxWindSpeed',width:60">最大风速(m/s)</th>
					<th data-options="field:'avgWindSpeed',width:60">平均风速(m/s)</th>
					<th data-options="field:'minWindSpeed',width:60">最小风速(m/s)</th>
					<th data-options="field:'maxCurp',width:60">最大有功(KW)</th>
					<th data-options="field:'avgCurp',width:60">平均有功(KW)</th>
					<th data-options="field:'minCurp',width:60">最小有功(KW)</th>
					<th data-options="field:'genwh',width:60">发电量(MWh)</th>
					<th data-options="field:'failDowntime',width:60">故障时间(h)</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

	<script type="text/javascript">
	
		function rtJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,最大风速（m/s）,平均风速（m/s）,最小风速（m/s）,最大有功,平均有功,最小有功,发电量,故障时间,";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].maxWindSpeed + "," + arrData.rows[i].avgWindSpeed + "," + arrData.rows[i].minWindSpeed + "," + arrData.rows[i].maxCurp + "," + arrData.rows[i].avgCurp + "," + arrData.rows[i].minCurp + "," + arrData.rows[i].genwh + "," + arrData.rows[i].failDowntime + ",";
					row.slice(0, row.length - 1);
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
	
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].maxWindSpeed.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].avgWindSpeed.replace(/<.*?>/ig, "");
				var str4 = arrData.rows[arrData.rows.length - 1].minWindSpeed.replace(/<.*?>/ig, "");
				var str5 = arrData.rows[arrData.rows.length - 1].maxCurp.replace(/<.*?>/ig, "");
				var str6 = arrData.rows[arrData.rows.length - 1].avgCurp.replace(/<.*?>/ig, "");
				var str7 = arrData.rows[arrData.rows.length - 1].minCurp.replace(/<.*?>/ig, "");
				var str8 = arrData.rows[arrData.rows.length - 1].genwh.replace(/<.*?>/ig, "");
				var str9 = arrData.rows[arrData.rows.length - 1].failDowntime.replace(/<.*?>/ig, "");
				row1 = str1 + "," + str2 + "," + str3 + "," + str4 + "," + str5 + "," + str6 + "," + str7 + "," + str8 + "," + str9 + ",";
				row1.slice(0, row1.length - 1);
				//在每一行之后添加一个换行符
				CSV += row1 + '\r\n';
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].avgWind + "," + arrData.rows[i].maxTime + "," + arrData.rows[i].maxWind + "," + arrData.rows[i].minTime + "," + arrData.rows[i].minWind + ",";
					row.slice(0, row.length - 1);
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
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
		function rtExporterExcel() {
			//获取datagrid对象
			var dg = $("#reportList");
			//获取所有行
			var rowTmp = $('#reportList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			rtJSONToCSVConvertor(rowTmp, "报表", true, true);
		}
	</script>

	<script type="text/javascript">
		//页面初始化,默认时间
		$(function() {
			//获取当前日期的零点
			var st = $("#rtStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
			//获取当前时间
			var et = $("#rtEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
			//var st = $("#rtStartTime").val("2019-01-01 12:44:21");
			//var et = $("#rtEndTime").val("2019-01-03 12:44:21");
			var stime = st.val();
			var etime = et.val();
			rtData(stime, etime);
		})
	
		//点击查询按钮
		function rtSelect() {
			var stime = $("#rtStartTime").val();
			var etime = $("#rtEndTime").val();
			rtData(stime, etime);
		}
		function rtData(stime, etime) {
			if ("" == stime || "" == etime || "" == (stime + "") || "" == (etime + "")) {
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
						text : ''
					});
					$(function() {
						$.ajax({
							url : 'ReportController/getReport',
							type : 'post',
							data : {
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								$("#reportList").datagrid('loadData', result);
								compute();
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		}
	
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function compute() { //计算函数
			var rows = $('#reportList').datagrid('getRows') //获取当前的数据行
			var maxWindSpeedTotal = 0, //计算listprice的总和
				windSpeedTotal = 0,
				minWindSpeedTotal = 0,
				maxCurpTotal = 0,
				curpTotal = 0,
				minCurpTotal = 0,
				genwhTotal = 0,
				failDowntimeTotal = 0;
	
			for (var i = 0; i < rows.length; i++) {
				if (parseFloat(rows[i]['maxWindSpeed']) > maxWindSpeedTotal) {
					maxWindSpeedTotal = parseFloat(rows[i]['maxWindSpeed']);
				}
				windSpeedTotal += parseFloat(rows[i]['avgWindSpeed']);
				if (parseFloat(rows[i]['minWindSpeed']) < minWindSpeedTotal) {
					minWindSpeedTotal = parseFloat(rows[i]['minWindSpeed']);
				}
				if (parseFloat(rows[i]['maxCurp']) > maxCurpTotal) {
					maxCurpTotal = parseFloat(rows[i]['maxCurp']);
				}
				curpTotal += parseFloat(rows[i]['avgCurp']);
				if (parseFloat(rows[i]['minCurp']) < minCurpTotal) {
					minCurpTotal = parseFloat(rows[i]['minCurp']);
				}
				genwhTotal += parseFloat(rows[i]['genwh']);
				failDowntimeTotal += parseFloat(rows[i]['failDowntime']);
			}
	
			// 			<th data-options="field:'name',width:60">风机名称</th>
			// 			<th data-options="field:'maxWindSpeed',width:60">最大风速</th>
			// 			<th data-options="field:'avgWindSpeed',width:60">平均风速</th>
			// 			<th data-options="field:'minWindSpeed',width:60">最小风速</th>
			// 			<th data-options="field:'maxCurp',width:60">最大有功</th>
			// 			<th data-options="field:'avgCurp',width:60">平均有功</th>
			// 			<th data-options="field:'minCurp',width:60">最小有功</th>
			// 			<th data-options="field:'genwh',width:60">发电量</th>
			// 			<th data-options="field:'failDowntime',width:60">故障时间</th>
	
			//新增一行显示统计信息
			$('#reportList').datagrid('appendRow', {
				name : '<b>综合计算</b>',
				maxWindSpeed : '<b>合计最大风速：</b>' + maxWindSpeedTotal.toFixed(3),
				avgWindSpeed : '<b>合计平均风速：</b>' + (windSpeedTotal / rows.length).toFixed(3),
				minWindSpeed : '<b>合计最小风速：</b>' + minWindSpeedTotal.toFixed(3),
				maxCurp : '<b>合计最大有功：</b>' + maxCurpTotal.toFixed(3),
				avgCurp : '<b>平均有功：</b>' + (curpTotal / rows.length).toFixed(3),
				minCurp : '<b>合计最小有功：</b>' + minCurpTotal.toFixed(3),
	
				genwh : '<b>合计发电量：</b>' + genwhTotal.toFixed(3),
				failDowntime : '<b>合计故障时间：</b>' + failDowntimeTotal.toFixed(3)
			// 				gt : '<b>合计平均可利用率：</b>' + utotal / rows.length,
			});
		}
	</script>

</body>
</html>
