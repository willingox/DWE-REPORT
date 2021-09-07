package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;
import cn.xjfd.ssm.service.ReportYCStatisticalInfoService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportYCStatisticalInfoController")
public class ReportYCStatisticalInfoController {

	@Autowired
	ReportYCStatisticalInfoService reportYCStatisticalInfoService;
	
	@ResponseBody
	@RequestMapping(value = "getYCSta", method = RequestMethod.POST)
	public List<YCReportData> getYCSta(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("selectValue") String[] selectValue, @RequestParam("ids") int[] ids) throws ParseException{
		
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		

		List<YCReportData> yCReportData = new ArrayList<YCReportData>();
		
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setStartTime(dateParameter.getStartTime());
		queryPeriod.setEndTime(dateParameter.getEndTime());
		queryPeriod.setYear(dateParameter.getStartYear());
		queryPeriod.setIds(ids);
//		List<HisImportantData> data[] = new ArrayList[selectValue.length];
//		List<HisImportantData>[] data = new List<HisImportantData>[selectValue.length];
		
String sql = "";
		
		for (int i = 0; i < selectValue.length; i++){
			String val = selectValue[i];
//			String[] r= val.split("-");
//			int id = Integer.parseInt(val);
//			queryPeriod.setId(id);
//			queryPeriod.setColumnname(val);
//			data[i] = reportYCMeasureInfoService.getYCMea(queryPeriod);
			String str = "ROUND(h." + val + ", 3) as cal" + i;
			if(i < selectValue.length - 1) {
				str += ",";
			}
			sql += str;
		}
		queryPeriod.setSql(sql);
//		hisImportantData.addAll(data[0]);
		yCReportData = reportYCStatisticalInfoService.getYCSta(queryPeriod);
		
	
		return yCReportData;
	}
}
