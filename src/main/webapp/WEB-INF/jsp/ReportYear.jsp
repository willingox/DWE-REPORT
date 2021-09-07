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

<title>年报表</title>
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
		选择时间&nbsp;<input type="text" id="rtyStartTime" name="startTime"
			class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp; 
			<button id="btn" type="button" onclick="rtySelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="rtyExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>
	</div>
	<div style="width: 2500px;overflow:auto">
		<table class="easyui-datagrid" id="reportYearList" title="风机年报表"
			style="width: auto;"
			data-options="singleSelect:false,fitColumns:true,striped:true,method:'get',showFooter: true">
			<thead>
				<tr>
					<th data-options="field:'name',width:60">风机名称</th>
					<th data-options="field:'yeargenwh',width:60">发电量(MWh)</th>
					<th data-options="field:'yeaAvlbltRat',width:60">可利用率(%)</th>
					<th data-options="field:'avg_windspeed',width:60">平均风速(m/s)</th>
					<th data-options="field:'yawCWCou',width:60">偏航总次数</th>
					<th data-options="field:'lftYawMotorCWCou',width:60">左偏航次数</th>
					<th data-options="field:'rtghYawMotorCCWCou',width:60">右偏航次数</th>
					<th data-options="field:'winTurStCovCont',width:60">停机次数</th>
					<th data-options="field:'winHigErrTimes',width:60">大风停机次数</th>
					<th data-options="field:'winTurArtStpCont',width:60">人工停机次数</th>
					<th data-options="field:'winTurErrCovCont',width:60">故障停机次数</th>
					<th data-options="field:'convMaiSwitchCou',width:60">并网次数</th>
					<th data-options="field:'winTurCatInCont',width:60">切入次数</th>
					<th data-options="field:'serModTimes',width:60">维护次数</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

	<script type="text/javascript">
	
		function rtyJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,发电量,可利用率,平均风速（m/s）,偏航总次数,左偏航次数,右偏航次数,停机次数,大风停机次数,人工停机次数,故障停机次数,并网次数,切入次数,维护次数,";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
	
	
					row = arrData.rows[i].name + "," + arrData.rows[i].yeargenwh + "," + arrData.rows[i].yeaAvlbltRat + "," + arrData.rows[i].avg_windspeed + ","
						+ arrData.rows[i].yawCWCou + "," + arrData.rows[i].lftYawMotorCWCou + "," + arrData.rows[i].rtghYawMotorCCWCou + ","
						+ arrData.rows[i].winTurStCovCont + "," + arrData.rows[i].winHigErrTimes + "," + arrData.rows[i].winTurArtStpCont + "," + arrData.rows[i].winTurErrCovCont + ","
						+ arrData.rows[i].convMaiSwitchCou + "," + arrData.rows[i].winTurCatInCont + "," + arrData.rows[i].serModTimes + ",";
	
					row.slice(0, row.length - 1);
	
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
	
				}
	
	
				var row1 = "";
				var str0 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str1 = arrData.rows[arrData.rows.length - 1].yeargenwh.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].yeaAvlbltRat.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].avg_windspeed.replace(/<.*?>/ig, "");
				var str12 = arrData.rows[arrData.rows.length - 1].yawCWCou.replace(/<.*?>/ig, "");
				var str13 = arrData.rows[arrData.rows.length - 1].lftYawMotorCWCou.replace(/<.*?>/ig, "");
				var str14 = arrData.rows[arrData.rows.length - 1].rtghYawMotorCCWCou.replace(/<.*?>/ig, "");
				var str15 = arrData.rows[arrData.rows.length - 1].winTurStCovCont.replace(/<.*?>/ig, "");
				var str16 = arrData.rows[arrData.rows.length - 1].winHigErrTimes.replace(/<.*?>/ig, "");
				var str17 = arrData.rows[arrData.rows.length - 1].winTurArtStpCont.replace(/<.*?>/ig, "");
				var str18 = arrData.rows[arrData.rows.length - 1].winTurErrCovCont.replace(/<.*?>/ig, "");
				var str19 = arrData.rows[arrData.rows.length - 1].convMaiSwitchCou.replace(/<.*?>/ig, "");
				var str20 = arrData.rows[arrData.rows.length - 1].winTurCatInCont.replace(/<.*?>/ig, "");
				var str21 = arrData.rows[arrData.rows.length - 1].serModTimes.replace(/<.*?>/ig, "");
				row1 = str0 + "," + str1 + "," + str2 + "," + str3 + "," + str12 + "," + str13 + "," + str14 + "," + str15 + "," + str16 + "," + str17 + "," + str18 + "," + str19 + "," + str20 + "," + str21 + ",";
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
		function rtyExporterExcel() {
			//获取datagrid对象
			var dg = $("#reportYearList");
			//获取所有行
			var rowTmp = $('#reportYearList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			rtyJSONToCSVConvertor(rowTmp, "年报表", true, true);
		}
	</script>

	<script type="text/javascript">
		//页面初始化,默认时间
		$(function() {
			//当前年
			var st = $("#rtyStartTime").val(new Date().format('yyyy'));
			//var st = $("#rtyStartTime").val("2019");
			var stime = st.val();
// 			alert(stime);
			rtyData(stime);
		})
	
		//点击查询按钮
		function rtySelect() {
			var stime = $("#rtyStartTime").val();
			
// 			alert(stime);
			rtyData(stime);
		}
		function rtyData(stime) {
			if (stime == "" || "" == (stime + "")) {
				alert("请输入日期！");
			} else {
				//获取当前年
// 				alert(stime);
				var year = new Date().getFullYear();
				var stimeYear = stime.substring(0, 4);
				if (stimeYear > year) {
					alert("您输入的年份不能超过当前年份！");
				} else {
					//数据加载时显示加载提示框
					$.messager.progress({
						title : '提示',
						msg : '数据请求中，请稍候……',
						text : ''
					});
					$(function() {
						$.ajax({
							url : 'ReportYearController/getReportYear',
							type : 'post',
							data : {
								"startTime" : stime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								$("#reportYearList").datagrid('loadData', result);
								rtySumData();
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		}
	
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function rtySumData() { //计算函数
			var rows = $('#reportYearList').datagrid('getRows') //获取当前的数据行
			var yeargenwhT = 0,
				yeaAvlbltRatT = 0,
				avg_windspeedT = 0,
				yawCWCouT = 0,
				lftYawMotorCWCouT = 0,
				rtghYawMotorCCWCouT = 0,
				winTurStCovContT = 0,
				winHigErrTimesT = 0,
				winTurArtStpContT = 0,
				winTurErrCovContT = 0,
				convMaiSwitchCouT = 0,
				winTurCatInContT = 0,
				serModTimesT = 0;
	
			for (var i = 0; i < rows.length; i++) {
				yeargenwhT += rows[i]['yeargenwh'];
				yeaAvlbltRatT += rows[i]['yeaAvlbltRat'];
				avg_windspeedT += rows[i]['avg_windspeed'];
				yawCWCouT += rows[i]['yawCWCou'];
				lftYawMotorCWCouT += rows[i]['lftYawMotorCWCou'];
				rtghYawMotorCCWCouT += rows[i]['rtghYawMotorCCWCou'];
				winTurStCovContT += rows[i]['winTurStCovCont'];
				winHigErrTimesT += rows[i]['winHigErrTimes'];
				winTurArtStpContT += rows[i]['winTurArtStpCont'];
				winTurErrCovContT += rows[i]['winTurErrCovCont'];
				convMaiSwitchCouT += rows[i]['convMaiSwitchCou'];
				winTurCatInContT += rows[i]['winTurCatInCont'];
				serModTimesT += rows[i]['serModTimes'];
			}
	
			//新增一行显示统计信息
			$('#reportYearList').datagrid('appendRow', {
				name : '<b>综合计算</b>',
				yeargenwh : '<b>合计发电量：</b>' + yeargenwhT.toFixed(3),
				yeaAvlbltRat : '<b>合计年可利用率：</b>' + (yeaAvlbltRatT / rows.length).toFixed(3),
				// 				gnme : '<b>合计利用小时数：</b>' + utotal / rows.length,
				avg_windspeed : '<b>合计平均风速：</b>' + (avg_windspeedT / rows.length).toFixed(3),
				yawCWCou : '<b>合计偏航总次数：</b>' + yawCWCouT,
				lftYawMotorCWCou : '<b>合计左偏航次数：</b>' + lftYawMotorCWCouT,
				rtghYawMotorCCWCou : '<b>合计右偏航次数：</b>' + rtghYawMotorCCWCouT,
				winTurStCovCont : '<b>合计停机次数：</b>' + winTurStCovContT,
				winHigErrTimes : '<b>合计大风停机次数：</b>' + winHigErrTimesT,
				winTurArtStpCont : '<b>合计人工停机次数：</b>' + winTurArtStpContT,
				winTurErrCovCont : '<b>合计故障停机次数：</b>' + winTurErrCovContT,
				convMaiSwitchCou : '<b>合计并网次数：</b>' + convMaiSwitchCouT,
				winTurCatInCont : '<b>合计切入次数：</b>' + winTurCatInContT,
				serModTimes : '<b>合计维护次数：</b>' + serModTimesT,
			});
		}
	</script>

</body>
</html>
