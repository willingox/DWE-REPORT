<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 判断页面有效性-->
<%-- <%
	Object uName = session.getAttribute("user");
	//判断用户是否登录
	if (uName == null) {
		//	session.setAttribute("errMsg", "你还没登录，请登录...");
		//重定向到登录页面
		//	response.sendRedirect("login");
	}
%> --%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<title>风功率散点</title>
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
		开始时间&nbsp;<input type="text" id="swpStartTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
		结束时间&nbsp;<input type="text" id="swpEndTime" class="Wdate"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
			data-options="required:true,editable:false"
			style="width: 160px; height: 22px;">&nbsp;&nbsp; 风机&nbsp; <select
			id="swpfanlist" style="vertical-align: middle;" name="name">
		</select> &nbsp;&nbsp;
		<button id="btn" type="button" onclick="swpSelect()"
			class="easyui-linkbutton" iconCls="icon-search">查询</button>
		&nbsp;&nbsp;
		<button id="csv" type="button" onclick="swpExporterExcel()"
			class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
	</div>
	<div id="swpmain" style="width: 100%; height: 400px;"></div>
	<div style="width: 100%">
		<table class="easyui-datagrid" id="scatterWindPowerList"
			title="风功率散点列表" style="width: auto;"
			data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'name',width:60">风机</th>
					<th data-options="field:'wind',width:100">风速(m/s)</th>
					<th data-options="field:'power',width:100">功率(KW)</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	
		function swpJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,风速（m/s）,功率（kW）";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
	
			for (var i = 0; i < (arrData.rows.length); i++) {
				var row = "";
				row = arrData.rows[i].name + "," + arrData.rows[i].wind + "," + arrData.rows[i].power + ",";
	
				row.slice(0, row.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row + '\r\n';
			}
	
	
			//第一个循环是提取每一行
	
	
			//           alert(CSV);
			if (CSV == '') {
				alert("无数据");
				return;
			}
			//Generate a file name
	
			// 　　　//这里我使用了当前时间用来为导出的文件命名
			// 		  var stime = $("#startTime").val();
			// 		  var etime = $("#endTime").val();
			var fileName = "";
			//           var fileName = getNowFormatDate();
			fileName += ReportTitle.replace(/ /g, "_");
	
			var link = document.createElement("a");
			//           var debug = {hello: CSV};
			var blob = new Blob([ CSV ], {
				type : 'text/csv'
			});
			//           var uri = 'data:text/csv;charset=utf-8,\ufeff' +CSV;  
	
			//           var blob = new Blob([uri], {type: 'text/csv'}); //解决大文件下载失败
			link.setAttribute("href", URL.createObjectURL(blob));
	
			//           link.href = uri;
	
			link.style = "visibility:hidden";
			link.download = fileName + ".csv";
	
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		}
	
	
		//导出CSV 获取easyui 表格数据
		function swpExporterExcel() {
			//获取datagrid对象
			var dg = $("#scatterWindPowerList");
			//获取所有行
			var rowTmp = $('#scatterWindPowerList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			swpJSONToCSVConvertor(rowTmp, "风功率散点数据", true, true);
		}
	</script>

	<script type="text/javascript">
		//页面初始化,默认时间
		//动态添加下拉列表	
		$(function() {
			//动态添加下拉列表	
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
	
						$("#swpfanlist").append("<option value='" + data[i].gid + "'>" + data[i].name + "</option>")
					}
	
					//获取当前日期的零点
					var st = $("#swpStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#swpEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#swpStartTime").val("2019-01-01 12:44:21");
					//var et = $("#swpEndTime").val("2019-01-20 12:44:21");
					//默认选中的风机value值
					var gid = data[0].gid;
					var stime = st.val();
					var etime = et.val();
					swpData(gid, stime, etime);
				}
			});
		});
		//点击查询按钮
		function swpSelect() {
			var gid = $("#swpfanlist").val();
			var stime = $("#swpStartTime").val();
			var etime = $("#swpEndTime").val();
			swpData(gid, stime, etime);
		}
		function swpData(gid, stime, etime) {
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
	
					var myChart = echarts.init(document.getElementById('swpmain'));
					$(function() {
						$.ajax({
							url : 'ScatterWindPowerController/getScatterWindPower',
							type : 'post',
							data : {
								"gid" : gid,
								"startTime" : stime,
								"endTime" : etime
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								var wind = [];
								var power = [];
								var powersdata = [];
								//$.messager.progress('close');
								$("#scatterWindPowerList").datagrid('loadData', result);
								for (var i = 0; i < result.length; i++) {
									wind.push(result[i].wind);
									power.push(result[i].power);
									powersdata.push([ result[i].wind, result[i].power ]);
								}
								// 指定图表的配置项和数据
								var option = {
									title : {
										text : '',
									},
									tooltip : {
										trigger : 'axis' //坐标轴触发
									},
									grid : {
										left : '7%',
										right : '7%'
									},
									/* legend : {
										data : [ '功率(KW)' ],
										left : 'right',
										align : 'left'
									}, */
									xAxis : {
										type : 'value',
										name : '风速',
										axisLabel : {
											formatter : '{value} m/s' //控制输出格式
										}
									// 										data : wind
									},
									yAxis : [
										//第一个Y轴坐标
										{
											type : 'value',
											name : '功率',
											axisLabel : {
												formatter : '{value} kW' //控制输出格式
											}
										}
									],
									scatter : {
										//symbol: null,      // 图形类型
										symbolSize : 1, // 图形大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2
										//symbolRotate : null,  // 图形旋转控制
										large : false, // 大规模散点图
										largeThreshold : 2000, // 大规模阀值，large为true且数据量>largeThreshold才启用大规模模式
										itemStyle : {
											normal : {
												// color: 各异,
												label : {
													show : false
												}
											},
											emphasis : {
												// color: '各异'
												label : {
													show : false
												}
											}
										}
									},
									series : [ {
										name : '功率',
										type : 'scatter',
										symbolSize : 5,
										xAxisIndex : 0,
										yAxisIndex : 0,
										itemStyle : {
											normal : {
												color : '#68CFE9', //散点颜色
											}
										},
										data : powersdata
									}
									]
								};
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
