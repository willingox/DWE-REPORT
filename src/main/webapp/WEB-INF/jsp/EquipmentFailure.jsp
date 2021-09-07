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

<title>风机故障查询</title>
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
		data-options="width:'100%',minHeight:820,noheader:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div style="float:left;width:20px;height:100%;display:flex;align-items:center;cursor:pointer;">
				<div style="position: fixed;z-index:999;height:80%;">
					<div id="ef1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("efWindName","efwindimgs")'>
							<img style="width:13px;height:13px" id="efwindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="efWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="ef2"
						style="width:18px;height:65px;margin-top:300px;text-align:center;background-color:#ffffff">
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>

			<div data-options="region:'center'"
				style="padding-left:20px;padding-top:5px;">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="efStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="efEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp; 选择类型：<label><input
						style="width:10px; vertical-align:-2px" name="checktype"
						type="radio" value="5" checked="checked" />故障</label>&nbsp; <label><input
						style="width:10px; vertical-align:-2px" name="checktype"
						type="radio" value="6" />告警</label>&nbsp; 
<!-- 						<label><input -->
<!-- 						style="width:10px; vertical-align:-2px" name="checktype" -->
<!-- 						type="radio" value="2" />事件</label> -->
						&nbsp;&nbsp;&nbsp; 关键字<input
						id="keywords" style="vertical-align: middle;" type="text" />&nbsp;&nbsp;&nbsp; 
						<button id="btn" type="button" onclick="efSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="efExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>
				</div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="equipmentFaultList"
						style="width: auto;" title="设备故障查询列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',width:50">风机名称</th>
								<th data-options="field:'failName',width:50">故障名称</th>
								<th data-options="field:'curcmpState',width:50">故障类型</th>
								<th data-options="field:'happenTime',width:50">故障发生时间</th>
								<th data-options="field:'removeTime',width:50">故障消除时间</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
		function efJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,故障名称,故障类型,故障发生时间,故障消除时间";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
	
			for (var i = 0; i < (arrData.rows.length); i++) {
				var row = "";
				row = arrData.rows[i].name + "," + arrData.rows[i].failName + "," + arrData.rows[i].curcmpState + "," + arrData.rows[i].happenTime + "," + arrData.rows[i].removeTime + ",";
	
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
		function efExporterExcel() {
			//获取datagrid对象
			var dg = $("#equipmentFaultList");
			//获取所有行
			var rowTmp = $('#equipmentFaultList').datagrid('getData');
			//        alert(rowTmp);
			if (rowTmp == '')
				return;
			efJSONToCSVConvertor(rowTmp, "设备故障", true, true);
		}
	</script>
	<!-- 页面实现复选框 -->
	<script>
	
		//鼠标事件（控制复选框下拉列表显隐）
		$('#ef2').mouseover(function() {
			if ($("#ef1").css("display") == "none") {
				$("#ef1").show(); //显示下拉框
				$("#ef2").hide(); //隐藏按钮
			} else {
				$("#ef1").hide(); //隐藏下拉框
				$("#ef2").show(); //显示按钮
	
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框，显示按钮
		$('#ef1').mouseleave(function() {
			$("#ef1").hide(); //隐藏下拉框
			$("#ef2").show(); //显示按钮
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
		function efCheckbox(ids) {
			obj = document.getElementsByName("efMycheck");
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
						$("#efWindName").append("<li>" + "<input name='efMycheck' style='width:10px' type='checkbox' value='" + result[i].gid + "'>" + result[i].name + "</li>");
	
					}
					//默认选中第一个复选框
					//$("input[name='efMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='efMycheck']").prop("checked", true);
					//页面初始化传值
					//获取当前日期的零点
					var st = $("#efStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#efEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#efStartTime").val("2019-01-01 12:44:21");
					//var et = $("#efEndTime").val("2019-01-05 12:44:21");
					var gids = [];
					efCheckbox(gids);
					var stime = st.val();
					var etime = et.val();
					var queryType = $('input[name="checktype"]:checked ').val(); //单选按钮值
					var keywords = $("#keywords").val(); //关键字
					efData(stime, etime, gids, queryType, keywords);
				}
			});
		});
		//点击查询按钮
		function efSelect() {
			var stime = $("#efStartTime").val();
			var etime = $("#efEndTime").val();
			var gids = [];
			efCheckbox(gids);
			var queryType = $('input[name="checktype"]:checked ').val();
			var keywords = $("#keywords").val();
			efData(stime, etime, gids, queryType, keywords);
		}
		;
	
		function efData(stime, etime, gids, queryType, keywords) {
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
	
					$.messager.progress({
						title : '提示',
						msg : '数据请求中，请稍候……',
						text : ''
					});
					$(function() {
						$.ajax({
							url : 'EquipmentFailureController/getEquipmentFailure',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"gids" : gids,
								"queryType" : queryType,
								"keywords" : keywords
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
								$("#equipmentFaultList").datagrid('loadData', result);
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		}
		;
	</script>
</body>
</html>
