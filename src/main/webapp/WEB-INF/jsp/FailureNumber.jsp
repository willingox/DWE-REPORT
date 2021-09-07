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

<title>故障次数</title>
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
	<div class="easyui-panel" title="Nested Panel"
		data-options="width:'100%',minHeight:0,noheader:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div
				style="float:left;width:20px;height:100%;display:flex;align-items:center;cursor:pointer;">
				<div style="position: fixed;z-index:999;height:80%;">
					<div id="fn1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("fnWindName","fnwindimgs")'>
							<img style="width:13px;height:13px" id="fnwindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="fnWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="fn2"
						style="width:18px;height:65px;margin-top:300px;text-align:center;background-color:#ffffff">
						<!-- <a href="#"><span>选择风机 </span></a> -->
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'" style="padding:5px">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="fnStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="fnEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;
					<!-- 						 <a -->
					<!-- 						href="javascript:void(0)" class="easyui-linkbutton" -->
					<!-- 						iconCls="icon-save" data-options="plain:true" onclick="fnSelect()">查询</a> -->
					<!-- 					<a href="javascript:void(0)" class="easyui-linkbutton" -->
					<!-- 						iconCls="icon-save" data-options="plain:true" -->
					<!-- 						onclick="fnExporterExcel()">CSV</a> -->
					<button id="btn" type="button" onclick="fnSelect()"
						class="easyui-linkbutton" iconCls="icon-search">查询</button>
					&nbsp;&nbsp;
					<button id="csv" type="button" onclick="fnExporterExcel()"
						class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
				</div>
				<div id="failNumBar" style="width: 100%; height: 400px;"></div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="failureNumberList"
						style="width: auto;" title="故障次数数据列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',width:50">风机名称</th>
								<th data-options="field:'failureNumber',width:50">故障次数</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
		function fnJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,故障次数";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
	
	
					row = arrData.rows[i].name + "," + arrData.rows[i].failureNumber + ",";
	
					row.slice(0, row.length - 1);
	
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
	
				}
	
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].failureNumber.replace(/<.*?>/ig, "");
	
	
				row1 = str1 + "," + str2 + ",";
	
	
				row1.slice(0, row1.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row1 + '\r\n';
	
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].failureNumber + ",";
	
					row.slice(0, row.length - 1);
	
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
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
		function fnExporterExcel() {
			//获取datagrid对象
			var dg = $("#failureNumberList");
			//获取所有行
			var rowTmp = $('#failureNumberList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			fnJSONToCSVConvertor(rowTmp, "风机故障次数", true, true);
		}
	</script>
	<!-- 页面实现复选框 -->
	<script>
		//鼠标事件（控制复选框下拉列表显隐）
		$('#fn2').mouseover(function() {
			if ($("#fn1").css("display") == "none") {
				$("#fn1").show(); //显示下拉框
				$("#fn2").hide(); //隐藏按钮
			} else {
				$("#fn1").hide(); //隐藏下拉框
				$("#fn2").show(); //显示按钮
	
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框显示按钮
		$('#fn1').mouseleave(function() {
			$("#fn1").hide(); //隐藏下拉框
			$("#fn2").show(); //显示按钮
		});
		//点击展开/关闭按钮出现风机复选框
		function show(c_Str, imgg) {
			if (document.all(c_Str).style.display == 'none') {
				document.all(c_Str).style.display = 'block';
				document.all(imgg).src = 'image/on.png'
			} else {
				document.all(c_Str).style.display = 'none';
				document.all(imgg).src = 'image/off.png'
			}
		}
	
		$(document).ready(function() {
			$("input:checkbox").click(function() {
				var objP = $(this).parent().parent();
				var objC = $(this).next();
				var len = $(objP).find("input:checkbox").length;
				//判断父级是否被选中
				if ($(objC).is("ul") && $(this).is("input:checkbox:checked")) {
					$(objC).find("input:checkbox").prop("checked", true);
				} else {
					$(objC).find("input:checkbox").prop("checked", false);
				}
			});
		});
	
		//选中风机复选框函数
		function fnCheckbox(ids) {
			obj = document.getElementsByName("fnMycheck");
			for (k in obj) {
				if (obj[k].checked) {
					ids.push(obj[k].value);
				}
			}
		}
	</script>

	<script type="text/javascript">
		//页面初始化
		$(function() {
			//动态获取风机名称生成复选框	
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(result) {
					for (var i = 0; i < result.length; i++) {
						//将获取的风机名称逐个填充到下拉列表中
						$("#fnWindName").append("<li>" + "<input name='fnMycheck' style='width:10px' type='checkbox' value='" + result[i].id + "'>" + result[i].name + "</li>");
	
					}
					//默认选中第一个复选框
					//$("input[name='fnMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='fnMycheck']").prop("checked", true);
					//页面初始化传值
					//获取当前日期的零点
					var st = $("#fnStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#fnEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#fnStartTime").val("2019-01-01 12:44:21");
					//var et = $("#fnEndTime").val("2019-01-02 12:44:21");
					var ids = [];
					fnCheckbox(ids);
					var stime = st.val();
					var etime = et.val();
					fnData(stime, etime, ids);
				}
			});
		});
	
		//点击查询按钮
		function fnSelect() {
			var stime = $("#fnStartTime").val();
			var etime = $("#fnEndTime").val();
			var ids = [];
			fnCheckbox(ids);
			fnData(stime, etime, ids);
		}
		;
	
		function fnData(stime, etime, ids) {
			if (ids.length == 0) {
				alert("请选择风机！");
			} else if (null == stime || null == etime || "" == (stime + "") || "" == (etime + "")) {
				alert("请输入日期！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else {
				$.messager.progress({
					title : '提示',
					msg : '数据请求中，请稍候……',
					text : ''
				});
				var stimeYear = stime.substring(0, 4);
				var etimeYear = etime.substring(0, 4);
				var yearCount = Number(etimeYear) - Number(stimeYear);
				if (yearCount > 1) {
					alert("查询时间过长！请缩短查询时间段！");
				} else {
	
					var myChart = echarts.init(document.getElementById('failNumBar'));
					$(function() {
						$.ajax({
							url : 'FailureNumberController/getFailureNumber',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"ids" : ids
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								$("#failureNumberList").datagrid('loadData', result);
								$.messager.progress('close');
								var name = [];
								var value = [];
								for (var i = 0; i < result.length; i++) {
									name.push(result[i].name);
									value.push(result[i].failureNumber);
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
										left : '5%',
										right : '5%'
									},
									/* legend : {
										data : [ '故障次数' ]
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
											name : '故障次数',
											axisLabel : {
												formatter : '{value}' //控制输出格式
											}
										}
									],
									series : [ {
										name : '故障次数',
										type : 'bar',
										itemStyle : {
											normal : {
												color : '#FF0000', //曲线颜色
											}
										},
										data : value
									}
									]
								};
								//清除画布缓存
								myChart.clear();
								// 使用刚指定的配置项和数据显示图表。
								myChart.setOption(option);
								fnSumData();
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		}
		;
	
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function fnSumData() { //计算函数
			var rows = $('#failureNumberList').datagrid('getRows') //获取当前的数据行
			var totalNumber = 0; //计算listprice的总和		
			for (var i = 0; i < rows.length; i++) {
				totalNumber += parseInt(rows[i]['failureNumber']);
			}
			var avgNumber = totalNumber / rows.length;
			avgNumber = avgNumber.toFixed(3);
	
			//新增一行显示统计信息
			$('#failureNumberList').datagrid('appendRow', {
				name : '<b>综合计算</b>',
				failureNumber : '<b>平均故障次数：</b>' + avgNumber,
			});
		}
	</script>
</body>
</html>
