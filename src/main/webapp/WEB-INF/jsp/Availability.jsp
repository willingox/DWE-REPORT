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

<title>风机可利用率</title>
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
		data-options="width:'100%',noheader:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div
				style="float:left;width:20px;height:100%;display:flex;align-items:center;cursor:pointer;">
				<div style="position: fixed;z-index:999;height:80%;">
					<div id="ab1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("abWindName","abwindimgs")'>
							<img style="width:13px;height:13px" id="abwindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="abWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="ab2"
						style="width:18px;height:68px;margin-top:300px;text-align:center;background-color:#ffffff">
						<!-- <a href="#"><span>选择风机 </span></a> -->
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'" style="padding:5px">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="abStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="abEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;
					<button id="btn" type="button" onclick="abSelect()"
						class="easyui-linkbutton" iconCls="icon-search">查询</button>
					&nbsp;&nbsp;
					<button id="csv" type="button" onclick="abExporterExcel()"
						class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
				</div>
				<div id="avaBar" style="width: 100%; height: 400px;"></div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="availabilityList"
						style="width: auto;" title="可利用率列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get',showFooter: true">
						<thead>
							<tr>
								<th data-options="field:'name',width:50">风机名称</th>
								<th data-options="field:'totalTime',width:50">总时间(h)</th>
								<th data-options="field:'availableTime',width:50">利用时间(h)</th>
								<th data-options="field:'failDownTime',width:50">故障时间(h)</th>
								<th data-options="field:'availability',width:50">可利用率(%)</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function abJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,总时间（h）,利用时间（h）,故障时间（h）,可利用率（%）";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].totalTime + "," + arrData.rows[i].availableTime + "," + arrData.rows[i].failDownTime + "," + arrData.rows[i].availability + ",";
	
					row.slice(0, row.length - 1);
	
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
	
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].totalTime.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].availableTime.replace(/<.*?>/ig, "");
				var str4 = arrData.rows[arrData.rows.length - 1].failDownTime.replace(/<.*?>/ig, "");
				var str5 = arrData.rows[arrData.rows.length - 1].availability.replace(/<.*?>/ig, "");
	
				row1 = str1 + "," + str2 + "," + str3 + "," + str4 + "," + str5 + ",";
				row1.slice(0, row1.length - 1);
	
				//在每一行之后添加一个换行符
				CSV += row1 + '\r\n';
	
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].totalTime + "," + arrData.rows[i].availableTime + "," + arrData.rows[i].failDownTime + "," + arrData.rows[i].availability + ",";
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
			link.style = "visibility:hidden";
			link.download = fileName + ".csv";
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		}
	
		//导出CSV 获取easyui 表格数据
		function abExporterExcel() {
			//获取datagrid对象
			var dg = $("#availabilityList");
			//获取所有行
			var rowTmp = $('#availabilityList').datagrid('getData');
			if (rowTmp == '')
				return;
			abJSONToCSVConvertor(rowTmp, "风机可利用率数据", true, true);
		}
	</script>
	<!-- 页面实现复选框 -->
	<script>
		//鼠标事件（控制复选框下拉列表显隐）
		$('#ab2').mouseover(function() {
			if ($("#ab1").css("display") == "none") {
				$("#ab1").show(); //显示
				$("#ab2").hide();
			} else {
				$("#ab1").hide(); //显示
				$("#ab2").show();
			}
		});
		//鼠标离开下拉框区域隐藏下拉框，显示按钮
		$('#ab1').mouseleave(function() {
			$("#ab1").hide(); //显示
			$("#ab2").show();
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
		//控制复选框单选/多选
		$(document).ready(function() {
			$("input:checkbox").click(function() {
				var objC = $(this).next();
				//判断父级是否被选中
				if ($(objC).is("ul") && $(this).is("input:checkbox:checked")) {
					$(objC).find("input:checkbox").prop("checked", true);
				} else {
					$(objC).find("input:checkbox").prop("checked", false);
				}
			});
		});
	
		//选中风机复选框函数
		function abCheckbox(ids) {
			obj = document.getElementsByName("abMycheck");
			for (k in obj) {
				if (obj[k].checked) {
					ids.push(obj[k].value);
				}
			}
		}
	</script>

	<!-- 页面实现复选框 -->
	<script>
		$(function() {
			//动态获取风机名称生成复选框	
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(result) {
					for (var i = 0; i < result.length; i++) {
						$("#abWindName").append("<li>" + "<input name='abMycheck' style='width:10px' type='checkbox' value='" + result[i].id + "'>" + result[i].name + "</li>");
					}
					//默认选中第一个复选框
					//$("input[name='abMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='abMycheck']").prop("checked", true);
					//获取当前日期的零点
					var st = $("#abStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#abEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#abStartTime").val("2019-01-01 12:44:21");
					//var et = $("#abEndTime").val("2019-01-02 12:44:21");
					var ids = [];
					abCheckbox(ids);
					var stime = st.val();
					var etime = et.val();
					abData(stime, etime, ids);
				}
			});
		});
	</script>

	<script type="text/javascript">
		//点击查询按钮
		function abSelect() {
			var stime = $("#abStartTime").val();
			var etime = $("#abEndTime").val();
			var ids = [];
			abCheckbox(ids);
			abData(stime, etime, ids);
		}
		;
	
		function abData(stime, etime, ids) {
			if (ids.length == 0) {
				alert("请选择风机！");
			} else if (null == stime || null == etime || "" == (stime + "") || "" == (etime + "")) {
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
					var myChart = echarts.init(document.getElementById('avaBar'));
					$(function() {
						$.ajax({
							url : 'AvailabilityController/getAvailabilityData',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"ids" : ids
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
	
								$("#availabilityList").datagrid('loadData', result);
								$.messager.progress('close');
								// 指定图表的配置项和数据
								var name = [];
								var availability = [];
								for (var i = 0; i < result.length; i++) {
									name.push(result[i].name);
									availability.push(result[i].availability);
								}
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
										data : [ '可利用率(%)' ]
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
											name : '可利用率(%)',
											axisLabel : {
												formatter : '{value}' //控制输出格式
											}
										}
									],
									series : [ {
										name : '可利用率(%)',
										type : 'bar',
										itemStyle : {
											normal : {
												color : '#68CFE9', //曲线颜色
											}
										},
										data : availability
									}
									]
								};
								//隐藏动画效果
								// myChart.hideLoading();
								//清除画布缓存
								myChart.clear();
								// 使用刚指定的配置项和数据显示图表。
								myChart.setOption(option);
								abSumData();
								//数据加载提示结束
	
							}
						})
					});
				}
			}
	
		}
		;
	
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function abSumData() { //计算函数
			var rows = $('#availabilityList').datagrid('getRows'); //获取当前的数据行
			var totalTime1 = rows[0]['totalTime']; //计算listprice的总和
			var totalAvailableTime = 0; //统计unitcost的总和
			var totalFailDownTime = 0;
			var totalAvailability = 0;
			for (var i = 0; i < rows.length; i++) {
				totalAvailableTime += rows[i]['availableTime'];
				totalFailDownTime += rows[i]['failDownTime'];
				// 				alert(totalFailDownTime);
				totalAvailability += rows[i]['availability'];
			// 				alert(totalAvailability);
			}
			var avgAvailableTime = totalAvailableTime / rows.length; //统计unitcost的总和
			var avgFailDownTime = totalFailDownTime / rows.length;
			var avgAvailability = totalAvailability / rows.length;
			avgAvailableTime = avgAvailableTime.toFixed(3);
			avgFailDownTime = avgFailDownTime.toFixed(3);
			avgAvailability = avgAvailability.toFixed(3);
			// 			fullAvailability
			// 			$("#fullAvailability").empty();
			// 			$("#fullAvailability").text("全场平均可利用率：" + (totalAvailability / rows.length) + "%");
			//新增一行显示统计信息
			$('#availabilityList').datagrid('appendRow', {
				// 				<th data-options="field:'name',width:50">风机名称</th>
				// 				<th data-options="field:'totalTime',width:50">总时间(h)</th>
				// 				<th data-options="field:'availableTime',width:50">利用时间(h)</th>
				// 				<th data-options="field:'failDownTime',width:50">故障时间(h)</th>
				// 				<th data-options="field:'availability',width:50">可利用率(%)</th>
				name : '<b>综合计算</b>',
				totalTime : '<b>总时间：</b>' + totalTime1,
				availableTime : '<b>平均利用时间：</b>' + avgAvailableTime,
				failDownTime : '<b>平均故障时间：</b>' + avgFailDownTime,
				availability : '<b>平均可利用率：</b>' + avgAvailability,
			});
		}
	</script>
</body>
</html>
