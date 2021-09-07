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
import cn.xjfd.ssm.pojo.EquipmentFailureData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportData;
import cn.xjfd.ssm.service.ReportService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportController")
public class ReportController {

	@Autowired
	ReportService reportService;
	
	@ResponseBody
	@RequestMapping(value = "getReport", method = RequestMethod.POST)
	public List<ReportData> getReport(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr) throws ParseException{
		
		List<ReportData> reportData = new ArrayList<ReportData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());
			
			reportData = reportService.getReport(queryPeriod);
			return reportData;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			
			
			List<ReportData> data1 = reportService.getReport(queryPeriod1);
			List<ReportData> data2 = reportService.getReport(queryPeriod2);
			
			for (int i = 0; i < data2.size(); i++) {
				double maxWindSpeed2 = Double.parseDouble(data2.get(i).maxWindSpeed);
				double avgWindSpeed2 = Double.parseDouble(data2.get(i).avgWindSpeed);
				double minWindSpeed2 = Double.parseDouble(data2.get(i).minWindSpeed);
				double maxCurp2 = Double.parseDouble(data2.get(i).maxCurp);
				double minCurp2 = Double.parseDouble(data2.get(i).minCurp);
				double avgCurp2 = Double.parseDouble(data2.get(i).avgCurp);
				double genwh2 = Double.parseDouble(data2.get(i).genwh);
				double failDowntime2 = Double.parseDouble(data2.get(i).failDowntime);
				
				for (int j = 0; j < data2.size(); j++) {
					
					double maxWindSpeed1 = Double.parseDouble(data1.get(j).maxWindSpeed);
					double avgWindSpeed1 = Double.parseDouble(data1.get(j).avgWindSpeed);
					double minWindSpeed1 = Double.parseDouble(data1.get(j).minWindSpeed);
					double maxCurp1 = Double.parseDouble(data1.get(j).maxCurp);
					double minCurp1 = Double.parseDouble(data1.get(j).minCurp);
					double avgCurp1 = Double.parseDouble(data1.get(j).avgCurp);
					double genwh1 = Double.parseDouble(data1.get(j).genwh);
					double failDowntime1 = Double.parseDouble(data1.get(j).failDowntime);
					
					if (data2.get(i).id == data1.get(j).id) {
						if (maxWindSpeed1 > maxWindSpeed2) {
							data2.get(j).setMaxWindSpeed(data1.get(i).maxWindSpeed);
						}
						data2.get(j).setAvgWindSpeed(String.valueOf((avgWindSpeed1 + avgWindSpeed2) / 2));
						if (minWindSpeed1 < minWindSpeed2) {
							data2.get(j).setMinWindSpeed(data1.get(i).minWindSpeed);
						}
						if (maxCurp1 > maxCurp2) {
							data2.get(j).setMaxCurp(data1.get(i).maxCurp);
						}
						if (minCurp1 < minCurp2) {
							data2.get(j).setMinCurp(data1.get(i).minCurp);
						}
						data2.get(j).setAvgCurp(String.valueOf((avgCurp1 + avgCurp2) / 2));
						data2.get(j).setGenwh(String.valueOf(genwh1 + genwh2));
						data2.get(j).setFailDowntime(String.valueOf(failDowntime1 +failDowntime2));
					}
					
				}
			}
			
			return data2;
		}
		return reportData;
		
	}
}
