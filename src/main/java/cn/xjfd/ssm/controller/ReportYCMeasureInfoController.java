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
import cn.xjfd.ssm.service.ReportYCMeasureInfoService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportYCMeasureInfoController")
public class ReportYCMeasureInfoController {

	@Autowired
	ReportYCMeasureInfoService reportYCMeasureInfoService;
	
	
	@ResponseBody
	@RequestMapping(value = "getYCMea", method = RequestMethod.POST)
	public List<YCReportData> getYCMea(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("selectValue") String[] selectValue, @RequestParam("ids") int[] ids) throws ParseException{
		
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
		yCReportData = reportYCMeasureInfoService.getYCMea(queryPeriod);
		
//		for (int i = 0; i < data[0].size(); i++) {
//			if (data[1] != null) {
//				hisImportantData.get(i).setCal1(data[1].get(i).getCal0());
//			}
//			if (data[2] != null) {
//				hisImportantData.get(i).setCal2(data[2].get(i).getCal0());
//			}
//			if (data[3] != null) {
//				hisImportantData.get(i).setCal3(data[3].get(i).getCal0());
//			}
//			if (data.length >= 5) {
//				hisImportantData.get(i).setCal4(data[4].get(i).getCal0());
//			}
//			
//			
//		}
		
	
		return yCReportData;
	}
	
}
