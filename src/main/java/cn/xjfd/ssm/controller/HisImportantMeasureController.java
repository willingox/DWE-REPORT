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

import cn.xjfd.ssm.pojo.AvailabilityData;
import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindInfo;
import cn.xjfd.ssm.service.HisImportantMeasureService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("HisImportantMeasureController")
public class HisImportantMeasureController {

	@Autowired
	HisImportantMeasureService hisImportantMeasureService;
	
	@ResponseBody
	@RequestMapping(value = "getHisImportant", method = RequestMethod.POST)
	public List<HisImportantData> getHisImportant(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("selectValue") String[] selectValue) throws ParseException{
		
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		

		List<HisImportantData> hisImportantData = new ArrayList<HisImportantData>();
		
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setStartTime(dateParameter.getStartTime());
		queryPeriod.setEndTime(dateParameter.getEndTime());
		queryPeriod.setYear(dateParameter.getStartYear());
		
		List<HisImportantData> data[] = new ArrayList[selectValue.length];
//		List<HisImportantData>[] data = new List<HisImportantData>[selectValue.length];
		
		for (int i = 0; i < selectValue.length; i++){
			String val = selectValue[i];
			String[] r= val.split("-");
			int id = Integer.parseInt(r[0]);
			queryPeriod.setId(id);
			queryPeriod.setColumnname(r[1]);
			data[i] = hisImportantMeasureService.getHisImportant(queryPeriod);
			
		}
		
		hisImportantData.addAll(data[0]);
		
		for (int i = 0; i < data[0].size(); i++) {
			if (data.length >= 2) {
				hisImportantData.get(i).setCal1(data[1].get(i).getCal0());
			}
			if (data.length >= 3) {
				hisImportantData.get(i).setCal2(data[2].get(i).getCal0());
			}
			if (data.length >= 4) {
				hisImportantData.get(i).setCal3(data[3].get(i).getCal0());
			}
			if (data.length >= 5) {
				hisImportantData.get(i).setCal4(data[4].get(i).getCal0());
			}
		
		
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
			
			
		}
		
	
		return hisImportantData;
	}
}
