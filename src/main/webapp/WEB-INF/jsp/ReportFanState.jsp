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

<title>风机状态统计</title>
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
				<div
					style="position: fixed;z-index:999;height:80%;display:flex;align-items:center;">
					<div id="rtfs1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer;">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("rtfsWindName","rtfswindimgs")'>
							<img style="width:13px;height:13px" id="rtfswindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer;"  value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="rtfsWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="rtfs2"
						style="width:18px;height:65px;margin-top:300px;text-align:center;background-color:#ffffff">
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'"
				style="padding-left:20px;padding-top:5px;">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="rtfsStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="rtfsEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;					
						<button id="btn" type="button" onclick="rtfsSelect()" class="easyui-linkbutton"
			iconCls="icon-search">查询</button>
		&nbsp;&nbsp;<button id="csv" type="button" onclick="rtfsExporterExcel()" class="easyui-linkbutton"
			iconCls="icon-save">导出CSV</button>
				</div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="fanStaList" style="width: auto;"
						title="风机状态统计列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get',showFooter: true">
						<thead>
							<tr>
								<th data-options="field:'name',width:50">风机名称</th>
								<th data-options="field:'plcState',width:50">风机(PLC)状态</th>
								<th data-options="field:'curTime',width:50">开始时间</th>
								<th data-options="field:'endTime',width:50">结束时间</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 页面实现复选框 -->
	<script type="text/javascript">
		function rtfsJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,风机(PLC)状态,开始时间,结束时间";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].plcState + "," + arrData.rows[i].curTime + "," + arrData.rows[i].endTime + ",";
					row.slice(0, row.length - 1);
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
	
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].genwh.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].capacity.replace(/<.*?>/ig, "");
				var str4 = arrData.rows[arrData.rows.length - 1].effectiveHours.replace(/<.*?>/ig, "");
				row1 = str1 + "," + str2 + "," + str3 + "," + str4 + ",";
				row1.slice(0, row1.length - 1);
				//在每一行之后添加一个换行符
				CSV += row1 + '\r\n';
	
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].plcState + "," + arrData.rows[i].curTime + "," + arrData.rows[i].endTime + ",";
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
		function rtfsExporterExcel() {
			//获取datagrid对象
			var dg = $("#fanStaList");
			//获取所有行
			var rowTmp = $('#fanStaList').datagrid('getData');
			if (rowTmp == '')
				return;
			rtfsJSONToCSVConvertor(rowTmp, "风机状态", true, false);
		}
	</script>

	<script>
		//鼠标事件（控制复选框下拉列表显隐）
		$('#rtfs2').mouseover(function() {
			if ($("#rtfs1").css("display") == "none") {
				$("#rtfs1").show(); //显示下拉框
				$("#rtfs2").hide(); //隐藏按钮
			} else {
				$("#rtfs1").hide(); //隐藏下拉框
				$("#rtfs2").show(); //显示按钮
	
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框显示按钮
		$('#rtfs1').mouseleave(function() {
			$("#rtfs1").hide(); //隐藏下拉框
			$("#rtfs2").show(); //显示按钮
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
		function rtfsCheckbox(ids) {
			obj = document.getElementsByName("rtfsMycheck");
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
					// 循环遍历获取风机名称填充到data数组中
					for (var i = 0; i < result.length; i++) {
						//将获取的风机名称逐个填充到下拉列表中
						$("#rtfsWindName").append("<li>" + "<input name='rtfsMycheck' style='width:10px' type='checkbox' value='" + result[i].gid + "'>" + result[i].name + "</li>");
					}
					//默认选中第一个复选框
					//$("input[name='rtfsMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='rtfsMycheck']").prop("checked", true);
					//页面初始化传值
					//获取当前日期的零点
					var st = $("#rtfsStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#rtfsEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#rtfsStartTime").val("2019-01-01 12:44:21");
					//var et = $("#rtfsEndTime").val("2019-01-02 12:44:21");
					var gids = [];
					rtfsCheckbox(gids)
					var stime = st.val();
					var etime = et.val();
					rtfsData(stime, etime, gids);
				}
			});
		});
	
		//点击查询按钮
		function rtfsSelect() {
			var stime = $("#rtfsStartTime").val();
			var etime = $("#rtfsEndTime").val();
			var gids = [];
			rtfsCheckbox(gids);
			rtfsData(stime, etime, gids);
		};
	
		function rtfsData(stime, etime, gids) {
			if (gids.length == 0) {
				alert("请选择风机！");
			} else if ("" == stime || "" == etime || "" == (stime + "") || "" == (etime + "")) {
				alert("请输入日期！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else { //获取当前年
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
							url : 'ReportFanStateFormController/getFanSta',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"gids" : gids
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
	
								$("#fanStaList").datagrid('loadData', result);
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
