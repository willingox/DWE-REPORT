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

<title>风机风速</title>
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
					<div id="ws1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("wsWindName","wswindimgs")'>
							<img style="width:13px;height:13px" id="wswindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="wsWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="ws2"
						style="width:18px;height:65px;margin-top:300px;text-align:center;background-color:#ffffff">
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'" style="padding:5px">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="wsStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="wsEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;
					<button id="btn" type="button" onclick="wsSelect()"
						class="easyui-linkbutton" iconCls="icon-search">查询</button>
					&nbsp;&nbsp;
					<button id="csv" type="button" onclick="wsExporterExcel()"
						class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
				</div>
				<div id="wsBar" style="width: 100%; height: 400px;"></div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="windSpeedList"
						style="width: auto;" title="风机风速数据列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',width:10">风机名称</th>
								<th data-options="field:'avgWind',width:18">平均风速（m/s）</th>
								<th data-options="field:'maxTime',width:18">最大风速时刻</th>
								<th data-options="field:'maxWind',width:18">最大风速（m/s）</th>
								<th data-options="field:'minTime',width:18">最小风速时刻</th>
								<th data-options="field:'minWind',width:18">最小风速（m/s）</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function wsJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,平均风速（m/s）,最大风速时刻,最大风速（m/s）,最小风速时刻,最小风速（m/s）";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].avgWind + "," + arrData.rows[i].maxTime + "," + arrData.rows[i].maxWind + "," + arrData.rows[i].minTime + "," + arrData.rows[i].minWind + ",";
					row.slice(0, row.length - 1);
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].avgWind.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].maxTime.replace(/<.*?>/ig, "");
				var str4 = arrData.rows[arrData.rows.length - 1].maxWind.replace(/<.*?>/ig, "");
				var str5 = arrData.rows[arrData.rows.length - 1].minTime.replace(/<.*?>/ig, "");
				var str6 = arrData.rows[arrData.rows.length - 1].minWind.replace(/<.*?>/ig, "");
				row1 = str1 + "," + str2 + "," + str3 + "," + str4 + "," + str5 + "," + str6 + ",";
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
		function wsExporterExcel() {
			//获取datagrid对象
			var dg = $("#windSpeedList");
			//获取所有行
			var rowTmp = $('#windSpeedList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			wsJSONToCSVConvertor(rowTmp, "风机风速", true, true);
		}
	</script>
	<!-- 页面实现复选框 -->
	<script>
		//鼠标事件（控制复选框下拉列表显隐）
		$('#ws2').mouseover(function() {
			if ($("#ws1").css("display") == "none") {
				$("#ws1").show(); //显示下拉框
				$("#ws2").hide(); //隐藏按钮
			} else {
				$("#ws1").hide(); //隐藏下拉框
				$("#ws2").show(); //显示按钮
	
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框显示按钮
		$('#ws1').mouseleave(function() {
			$("#ws1").hide(); //隐藏下拉框
			$("#ws2").show(); //显示按钮
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
				//判断子级是否全部被选中
				/* 		if ($(objP).find("input:checkbox:checked").length == len) {
							$(objP).prev("input:checkbox").prop("checked", true);
						} else {
							$(objP).prev("input:checkbox").prop("checked", false);
						} */
	
	
			});
		});
	
		//选中风机复选框函数
		function wsCheckbox(ids) {
			obj = document.getElementsByName("wsMycheck");
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
						$("#wsWindName").append("<li>" + "<input name='wsMycheck' style='width:10px' type='checkbox' value='" + result[i].gid + "'>" + result[i].name + "</li>");
					}
					//默认选中第一个复选框
					//$("input[name='wsMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='wsMycheck']").prop("checked", true);
					//页面初始化传值
					//获取当前日期的零点
					var st = $("#wsStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#wsEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#wsStartTime").val("2019-01-01 12:44:21");
					//var et = $("#wsEndTime").val("2019-01-22 12:44:21");
					var gids = [];
					wsCheckbox(gids);
					var stime = st.val();
					var etime = et.val();
// 					wsdata(stime, etime, gids);
				}
			});
		});
	
		//点击查询按钮
		function wsSelect() {
			var stime = $("#wsStartTime").val();
			var etime = $("#wsEndTime").val();
			var gids = [];
			wsCheckbox(gids);
			wsdata(stime, etime, gids);
		}
		;
	
		function wsdata(stime, etime, gids) {
			if (gids.length == 0) {
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
					/* function load() {
						$("<div class=\"datagrid-mask\"></div>").css({
							display : "block",
							width : "100%",
							height : $(window).height()
						}).appendTo("body");
						$("<div class=\"datagrid-mask-msg\"></div>").html("邮件发送中，请稍候。。。").appendTo("body").css({
							display : "block",
							left : ($(document.body).outerWidth(true) - 190) / 2,
							top : ($(window).height() - 45) / 2
						});
					} */
					$.messager.progress({
						title : '提示',
						//showClose : true,
						msg : '数据请求中，请稍候……',
					//value : 0,
					//interval : 0
					});
	
					var myChart = echarts.init(document.getElementById('wsBar'));
					$(function() {
						$.ajax({
							url : 'WindSpeedController/getWindSpeed',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"gids" : gids
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								$("#windSpeedList").datagrid('loadData', result);
								$.messager.progress('close');
								var name = [];
								var value = [];
								for (var i = 0; i < result.length; i++) {
									name.push(result[i].name);
									value.push(result[i].avgWind);
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
										data : [ '平均风速' ]
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
											name : '平均风速',
											axisLabel : {
												formatter : '{value}' //控制输出格式
											}
										}
									],
									series : [ {
										name : '平均风速',
										type : 'bar',
										itemStyle : {
											normal : {
												color : '#87CEEB', //曲线颜色
											}
										},
										data : value
									}
									]
								};
								//隐藏动画效果
								// myChart.hideLoading();
								myChart.clear();
								// 使用刚指定的配置项和数据显示图表。
								myChart.setOption(option);
								wsSumData();
								//数据加载提示结束
								$.messager.progress('close');
								/* function disLoad() {
									$(".datagrid-mask").remove();
									$(".datagrid-mask-msg").remove();
								} */
							}
						})
					});
				}
			}
		}
		;
	
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function wsSumData() { //计算函数
			var rows = $('#windSpeedList').datagrid('getRows') //获取当前的数据行
			var totalAvgWind = 0; //计算listprice的总和	
			var totalMaxWind = parseFloat(rows[0]['maxWind']);
			var totalMaxTime = rows[0]['maxTime'];
			var totalMinWind = parseFloat(rows[0]['minWind']);
			var totalMinTime = rows[0]['minTime'];
			for (var i = 0; i < rows.length; i++) {
				totalAvgWind += parseFloat(rows[i]['avgWind']);
				if (parseFloat(rows[i]['maxWind']) > totalMaxWind) {
					totalMaxWind = parseFloat(rows[i]['maxWind']);
					totalMaxTime = rows[i]['maxTime'];
				}
				if (parseFloat(rows[i]['minWind']) < totalMinWind) {
					totalMinWind = parseFloat(rows[i]['minWind']);
					totalMinTime = rows[i]['minTime'];
				}
			}
			totalAvgWind = totalAvgWind / rows.length;
			totalAvgWind = totalAvgWind.toFixed(3);
	
			//新增一行显示统计信息
			$('#windSpeedList').datagrid('appendRow', {
				name : '<b>综合计算</b>',
				avgWind : '<b>全场平均风速：</b>' + totalAvgWind,
				maxTime : '<b>全场最大风速时刻：</b>' + totalMaxTime,
				maxWind : '<b>全场最大风速：</b>' + totalMaxWind,
				minTime : '<b>全场最小风速时刻：</b>' + totalMinTime,
				minWind : '<b>全场最小风速：</b>' + totalMinWind,
			});
		}
	</script>
</body>
</html>
