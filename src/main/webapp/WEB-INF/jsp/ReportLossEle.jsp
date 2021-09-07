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

<title>损失电量报表</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="easyui/js/datagrid-export.js"></script>
</head>
<body>
	<div class="easyui-panel" title="Nested Panel"
		data-options="width:'100%',minHeight:0,noheader:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div
				style="float:left;width:20px;height:100%;display:flex;align-items:center;cursor:pointer;">
				<div
					style="position: fixed;z-index:999;height:80%;display:flex;align-items:center;">
					<div id="rtle1"
						style="overflow:auto;width:210px;height:100%;float:left;display:none;background-color:#ffffff;cursor:pointer;">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("rtleWindName","rtlewindimgs")'>
							<img style="width:13px;height:13px" id="rtlewindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer;" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="rtleWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="rtle2"
						style="width:18px;height:65px;margin-top:300px;text-align:center;background-color:#ffffff">
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'"
				style="padding-left:20px;padding-top:5px;">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="rtleStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="rtleEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;
					<button id="btn" type="button" onclick="rtleSelect()"
						class="easyui-linkbutton" iconCls="icon-search">查询</button>
					&nbsp;&nbsp;
					<button id="csv" type="button" onclick="rtleExporterExcel()"
						class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
				</div>
				<div style="width: 100%">
					<table class="easyui-datagrid" id="lossEleList"
						style="width: auto;" title="损失电量列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',width:50">风机名称</th>
								<th data-options="field:'gridErrStopHour',width:50">电网故障停运小时数</th>
								<th data-options="field:'weaErrStopHour',width:50">天气原因停运小时数</th>
								<th data-options="field:'hMIStopHour',width:50">就地停机停运小时数</th>
								<th data-options="field:'remoteStopHour',width:50">远程停机停运小时数</th>
								<th data-options="field:'errBreakHour',width:50">故障停机停运小时数</th>
								<th data-options="field:'powLimHour',width:50">限功率小时数</th>
								<th data-options="field:'gridErrPowSum',width:50">电网故障停运损失发电量</th>
								<th data-options="field:'weaErrPowSum',width:50">天气原因损失发电量</th>
								<th data-options="field:'hMIStopPowSum',width:50">就地停机停运损失发电量</th>
								<th data-options="field:'remoteStopPowSum',width:50">远程停机停运损失发电量</th>
								<th data-options="field:'errBreakPowSum',width:50">故障停机损失电量</th>
								<th data-options="field:'powLimPowSum',width:50">限功率损失电量</th>
								<th data-options="field:'hiddenPow',width:50">潜能发电量</th>
								<th data-options="field:'capAva',width:50">产能可利用率</th>
								<th data-options="field:'avaHours',width:50">可利用小时数</th>
								<th data-options="field:'hoursSum',width:50">时长合计</th>
								<th data-options="field:'lossGenSum',width:50">损失电量合计</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 页面实现复选框 -->
	<script type="text/javascript">
		function rtleJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
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
				row = "风机名称,电网故障停运小时数,天气原因停运小时数,就地停机停运小时数,远程停机停运小时数,故障停机停运小时数,限功率小时数,电网故障停运损失发电量,天气原因损失发电量,就地停机停运损失发电量,远程停机停运损失发电量,故障停机损失电量,限功率损失电量,潜能发电量,产能可利用率,可利用小时数,时长合计,损失电量合计";
				//用换行符追加标签行
				CSV += row + '\r\n';
			}
	
			if (removeLabel) {
				for (var i = 0; i < (arrData.rows.length - 1); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].gridErrStopHour + "," + arrData.rows[i].weaErrStopHour + "," + arrData.rows[i].hMIStopHour + "," + arrData.rows[i].remoteStopHour + "," + arrData.rows[i].errBreakHour + "," + arrData.rows[i].powLimHour + "," + arrData.rows[i].gridErrPowSum + "," + arrData.rows[i].weaErrPowSum + "," + arrData.rows[i].hMIStopPowSum + "," + arrData.rows[i].remoteStopPowSum + "," + arrData.rows[i].errBreakPowSum + "," + arrData.rows[i].powLimPowSum + "," + arrData.rows[i].hiddenPow + "," + arrData.rows[i].capAva + "," + arrData.rows[i].avaHours + "," + arrData.rows[i].hoursSum + "," + arrData.rows[i].lossGenSum + ",";
					row.slice(0, row.length - 1);
					//在每一行之后添加一个换行符
					CSV += row + '\r\n';
				}
				var row1 = "";
				var str1 = arrData.rows[arrData.rows.length - 1].name.replace(/<.*?>/ig, "");
				var str2 = arrData.rows[arrData.rows.length - 1].gridErrStopHour.replace(/<.*?>/ig, "");
				var str3 = arrData.rows[arrData.rows.length - 1].weaErrStopHour.replace(/<.*?>/ig, "");
				var str4 = arrData.rows[arrData.rows.length - 1].hMIStopHour.replace(/<.*?>/ig, "");
				var str5 = arrData.rows[arrData.rows.length - 1].remoteStopHour.replace(/<.*?>/ig, "");
				var str6 = arrData.rows[arrData.rows.length - 1].errBreakHour.replace(/<.*?>/ig, "");
				var str7 = arrData.rows[arrData.rows.length - 1].powLimHour.replace(/<.*?>/ig, "");
				var str8 = arrData.rows[arrData.rows.length - 1].gridErrPowSum.replace(/<.*?>/ig, "");
				var str9 = arrData.rows[arrData.rows.length - 1].weaErrPowSum.replace(/<.*?>/ig, "");
				var str10 = arrData.rows[arrData.rows.length - 1].hMIStopPowSum.replace(/<.*?>/ig, "");
				var str11 = arrData.rows[arrData.rows.length - 1].remoteStopPowSum.replace(/<.*?>/ig, "");
				var str12 = arrData.rows[arrData.rows.length - 1].errBreakPowSum.replace(/<.*?>/ig, "");
				var str13 = arrData.rows[arrData.rows.length - 1].powLimPowSum.replace(/<.*?>/ig, "");
				var str14 = arrData.rows[arrData.rows.length - 1].hiddenPow.replace(/<.*?>/ig, "");
				var str15 = arrData.rows[arrData.rows.length - 1].capAva.replace(/<.*?>/ig, "");
				var str16 = arrData.rows[arrData.rows.length - 1].avaHours.replace(/<.*?>/ig, "");
				var str17 = arrData.rows[arrData.rows.length - 1].hoursSum.replace(/<.*?>/ig, "");
				var str18 = arrData.rows[arrData.rows.length - 1].lossGenSum.replace(/<.*?>/ig, "");
				row1 = str1 + "," + str2 + "," + str3 + "," + str4 + "," + str5 + "," + str6 + "," + str7 + "," + str8 + "," + str9 + "," + str10 + "," + str11 + "," + str12 + "," + str13 + "," + str14 + "," + str15 + "," + str16 + "," + str17 + "," + str18 + ",";
				row1.slice(0, row1.length - 1);
				//在每一行之后添加一个换行符
				CSV += row1 + '\r\n';
			} else {
				for (var i = 0; i < (arrData.rows.length); i++) {
					var row = "";
					row = arrData.rows[i].name + "," + arrData.rows[i].gridErrStopHour + "," + arrData.rows[i].weaErrStopHour + "," + arrData.rows[i].hMIStopHour + "," + arrData.rows[i].remoteStopHour + "," + arrData.rows[i].errBreakHour + "," + arrData.rows[i].powLimHour + "," + arrData.rows[i].gridErrPowSum + "," + arrData.rows[i].weaErrPowSum + "," + arrData.rows[i].hMIStopPowSum + "," + arrData.rows[i].remoteStopPowSum + "," + arrData.rows[i].errBreakPowSum + "," + arrData.rows[i].powLimPowSum + "," + arrData.rows[i].hiddenPow + "," + arrData.rows[i].capAva + "," + arrData.rows[i].avaHours + "," + arrData.rows[i].hoursSum + "," + arrData.rows[i].lossGenSum + ",";
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
		function rtleExporterExcel() {
			//获取datagrid对象
			var dg = $("#lossEleList");
			//获取所有行
			var rowTmp = $('#lossEleList').datagrid('getData');
			if (rowTmp == '')
				return;
			rtleJSONToCSVConvertor(rowTmp, "损失电量报表", true, false);
		}
	</script>

	<script>
		//鼠标事件（控制复选框下拉列表显隐）
		$('#rtle2').mouseover(function() {
			if ($("#rtle1").css("display") == "none") {
				$("#rtle1").show(); //显示下拉框
				$("#rtle2").hide(); //隐藏按钮
			} else {
				$("#rtle1").hide(); //隐藏下拉框
				$("#rtle2").show(); //显示按钮
	
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框显示按钮
		$('#rtle1').mouseleave(function() {
			$("#rtle1").hide(); //隐藏下拉框
			$("#rtle2").show(); //显示按钮
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
		function rtleCheckbox(ids) {
			obj = document.getElementsByName("rtleMycheck");
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
						$("#rtleWindName").append("<li>" + "<input name='rtleMycheck' style='width:10px' type='checkbox' value='" + result[i].gid + "'>" + result[i].name + "</li>");
					}
					//默认选中第一个复选框
					//$("input[name='rtleMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='rtleMycheck']").prop("checked", true);
					//页面初始化传值
					//获取当前日期的零点
					var st = $("#rtleStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
					//获取当前时间
					var et = $("#rtleEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
					//var st = $("#rtleStartTime").val("2019-11-01 12:44:21");
					//var et = $("#rtleEndTime").val("2019-11-02 12:44:21");
					var gids = [];
					rtleCheckbox(gids)
					var stime = st.val();
					var etime = et.val();
					rtleData(stime, etime, gids);
				}
			});
		});
		//点击查询按钮
		function rtleSelect() {
			var stime = $("#rtleStartTime").val();
			var etime = $("#rtleEndTime").val();
// 			alert(stime);
// 			alert(etime);
			var gids = [];
			rtleCheckbox(gids);
// 			alert(gids);
			rtleData(stime, etime, gids);
		}
		;
	
		function rtleData(stime, etime, gids) {
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
							url : 'ReportLossEleController/getReportLossEle',
							type : 'post',
							traditional : true,
							data : {
								"startTime" : stime,
								"endTime" : etime,
								"gids" : gids
							}, //向后台传参
							datatype : 'json',
							success : function(result) {
	
								$("#lossEleList").datagrid('loadData', result);
								rtleSumData();
								//数据加载提示结束
								$.messager.progress('close');
							}
						})
					});
				}
			}
		};
		//列表列值总和、平均值计算并增加列表行绑定到计算值到列表
		function rtleSumData() { //计算函数
			var rows = $('#lossEleList').datagrid('getRows'); //获取当前的数据行
			var geshSum = 0;  //电网故障停运小时数总和
			var weshSum = 0;  //天气原因停运小时数总和	
			var	hmshSum = 0;  //就地停机停运小时数总和
			var rshSum = 0;   //远程停机停运小时数总和
			var	ebhSum = 0;   //故障停机停运小时数总和
			var	plhSum = 0;   //限功率小时数总和
			var	gepsSum = 0;  //电网故障停运损失发电量总和
			var	wepsSum = 0;  //天气原因损失发电量总和
			var	hmspsSum = 0; //就地停机停运损失发电量总和
			var	rspsSum = 0;  //远程停机停运损失发电量总和
			var	ebpsSum = 0;  //故障停机损失电量总和
			var	plpsSum = 0;  //限功率损失电量总和
			var	hpSum = 0;    //潜能发电量总和
			var	caSum = 0;    //产能可利用率总和
			var	ahSum = 0;    //可利用小时数总和
			var	hsSum = 0;    //时长合计总和
			var	lgSum = 0;    //损失电量合计总和
			for (var i = 0; i < rows.length; i++) {
				geshSum += rows[i]['gridErrStopHour'];
				weshSum += rows[i]['weaErrStopHour'];
				hmshSum += rows[i]['hMIStopHour'];
				rshSum += rows[i]['remoteStopHour'];
				ebhSum += rows[i]['errBreakHour'];
				plhSum += rows[i]['powLimHour'];
				gepsSum += rows[i]['gridErrPowSum'];
				wepsSum += rows[i]['weaErrPowSum'];
				hmspsSum += rows[i]['hMIStopPowSum'];
				rspsSum += rows[i]['remoteStopPowSum'];
				ebpsSum += rows[i]['errBreakPowSum'];
				plpsSum += rows[i]['powLimPowSum'];
				hpSum += rows[i]['hiddenPow'];
				caSum += rows[i]['capAva'];
				ahSum += rows[i]['avaHours'];
				hsSum += rows[i]['hoursSum'];
				lgSum += rows[i]['lossGenSum'];
			}
			geshSum = geshSum.toFixed(3);
			weshSum = weshSum.toFixed(3);
			hmshSum = hmshSum.toFixed(3);
			rshSum = rshSum.toFixed(3);
			ebhSum = ebhSum.toFixed(3);
			plhSum = plhSum.toFixed(3);
			gepsSum = gepsSum.toFixed(3);
			wepsSum = wepsSum.toFixed(3);
			hmspsSum = hmspsSum.toFixed(3);
			rspsSum = rspsSum.toFixed(3);
			ebpsSum = ebpsSum.toFixed(3);
			plpsSum = plpsSum.toFixed(3);
			hpSum = hpSum.toFixed(3);
			caSum = caSum.toFixed(3);
			ahSum = ahSum.toFixed(3);
			hsSum = hsSum.toFixed(3);
			lgSum = lgSum.toFixed(3);
			//新增一行显示统计信息
			$('#lossEleList').datagrid('appendRow', {
				name : '合计',
				gridErrStopHour : geshSum,
				weaErrStopHour:weshSum,
				hMIStopHour:hmshSum,
				remoteStopHour:rshSum,
				errBreakHour:ebhSum,
				powLimHour:plhSum,
				gridErrPowSum:gepsSum,
				weaErrPowSum:wepsSum,
				hMIStopPowSum:hmspsSum,
				remoteStopPowSum:rspsSum,
				errBreakPowSum:ebpsSum,
				powLimPowSum:plpsSum,
				hiddenPow:hpSum,
				capAva:caSum,
				avaHours:ahSum,
				hoursSum:hsSum,
				lossGenSum:lgSum
			});
		}
	</script>
</body>
</html>
