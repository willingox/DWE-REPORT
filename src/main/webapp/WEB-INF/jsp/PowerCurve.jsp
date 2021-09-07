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
<title>功率曲线</title>
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
		开始时间&nbsp;<input type="text" id="pcStarTtime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="pcEndTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp; 风机&nbsp; <select
			id="pcFanlist" style="vertical-align: middle;" name="name">
			<!-- <option value="-1">请选择风机</option> -->
		</select> &nbsp;&nbsp;
			<button id="btn" type="button" onclick="pcSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="pcExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>
	</div>
	<div id="pcmain" style="width: 100%; height: 400px;"></div>
	<div style="width: 100%">
		<table class="easyui-datagrid" id="powerCurveData" title="风机功率曲线数据列表"
			style="width: auto;"
			data-options="singleSelect:false,collapsible:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'windvelval',width:60">风速区间(m/s)</th>
					<th data-options="field:'curp',width:100">实际功率(KW)</th>
					<th data-options="field:'genpwd',width:100">合同保证功率(KW)</th>
				</tr>
			</thead>
		</table>
	</div>


	<script type="text/javascript">
		function pcJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
			//如果JSONData不是对象，那么JSON。parse将解析对象中的JSON字符串
			var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
				: JSONData;
			var CSV = '';
			//在第一行或第一行设置报表标题
			CSV += ReportTitle + '\r\n\n';
			//此条件将生成标签/标头
			if (ShowLabel) {
				var row = "";
				//导出的标题
				row = "风速,合同保证功率,实际功率";
				//用换行符追加标签
				CSV += row + '\r\n';
			}
			//第一个循环是提取每一行
			for (var i = 0; i < arrData.rows.length; i++) {
				var row = "";
				row = arrData.rows[i].windvelval + "," + arrData.rows[i].genpwd + "," + arrData.rows[i].curp + ",";
				row.slice(0, row.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row + '\r\n';
			}
			if (CSV == '') {
				alert("无数据");
				return;
			}
			var fileName = "";
			//           var fileName = getNowFormatDate();
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
		function pcExporterExcel() {
			//获取datagrid对象
			var dg = $("#powerCurveData");
			//获取所有行
			var rowTmp = $('#powerCurveData').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			pcJSONToCSVConvertor(rowTmp, "功率曲线数据", true);
		}
	</script>

	<script type="text/javascript">
	
		//页面初始化,默认时间
		$(function() {
			//动态添加下拉列表	
			$.ajax({
				type : "GET",
				url : "getWindNameController/getWindName",
				datatype : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
						$("#pcFanlist").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>")
					}
					//获取当前日期的前一周
// 					var st = $("#pcStartTime").val(new Date(new Date().getTime() - (7*24 * 60 * 60 * 1000)).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
// 					alert(new Date(new Date().getTime() - (7*24 * 60 * 60 * 1000)).format('yyyy-MM-dd hh:mm:ss'));
					var et = $("#pcEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
// 					alert(et);
					var st = $("#pcStarTtime").val(new Date(new Date().getTime() - (7*24 * 60 * 60 * 1000)).format('yyyy-MM-dd hh:mm:ss'));
					//var et = $("#pcEndTime").val("2019-01-18 12:44:21");
					//默认选中的风机value值
					var id = data[0].id;
					var stime = st.val();
					var etime = et.val();
					pcData(id, stime, etime);
				}
			});
		})
	
		function pcSelect() {
			var id = $("#pcFanlist").val();
			var stime = $("#pcStarTtime").val();
			var etime = $("#pcEndTime").val();
			pcData(id, stime, etime);
		}
		function pcData(id, stime, etime) {
			if (stime == "" || etime == "") {
				alert("请输入日期！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else if (id == "") {
				alert("请选择风机！");
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
					var myChart = echarts.init(document.getElementById('pcmain'));
					$(function() {
						$.ajax({
							url : 'PowerCurveController/getPowerCurveData',
							type : 'post',
							data : {
								"id" : id,
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								var windvelval = [];
								var genpwd = [];
								var curp = [];
								for (var i = 0; i < result.length; i++) {
									windvelval.push(result[i].windvelval);
									genpwd.push(result[i].genpwd);
									curp.push(result[i].curp);
								}
								$("#powerCurveData").datagrid('loadData', result);
								// 指定图表的配置项和数据
								var option = {
									title : {
										text : '',
									},
									tooltip : {
										trigger : 'axis' //坐标轴触发
									},
									grid : {
										left : '6%',
										right : '6%'
									},
									legend : {
										data : [ '实际功率','合同保证功率' ],
										left : 'center',
										align : 'left'
									},
									xAxis : {
										type : 'category',
										name : '风速',
										data : windvelval
									},
									yAxis : [
										//第一个Y轴坐标
										{
											type : 'value',
											name : '功率',
											axisLabel : {
												formatter : '{value}' //控制输出格式
											}
										}
									],
									series : [ {
										name : '实际功率',
										type : 'line',
										smooth : 'true', //折线图变曲线图
										symbol : 'none', //设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形  
										itemStyle : {
											normal : {
												color : '#68CFE9', //曲线颜色
												lineStyle : {
													width : 2 //曲线粗细
													
												}
												
											}
											
										},
										data : curp
									},
										{
											name : '合同保证功率',
											type : 'line', //折线图表示（生成温度曲线）
											//yAxisIndex: 1, //主要是针对第二个Y轴
											smooth : 'true',
											symbol : 'none', //设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形  
											itemStyle : {
												normal : {
													color : '#B15BFF',
													lineStyle : {
														width : 2
													}
													
												}
											},
											data : genpwd //数据值通过Ajax动态获取
										}
									]
								};
								//隐藏动画效果
								// myChart.hideLoading();
								//清除画布缓存
								myChart.clear();
								// 使用刚指定的配置项和数据显示图表。
								myChart.setOption(option);
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
