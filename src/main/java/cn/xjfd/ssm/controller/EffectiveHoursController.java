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
import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.EffectiveHoursService;
import cn.xjfd.ssm.util.DataAccuracy;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("EffectiveHoursController")
public class EffectiveHoursController {

	@Autowired
	EffectiveHoursService effectiveHoursService;
	
	@ResponseBody
	@RequestMapping(value = "getEffectiveHours", method = RequestMethod.POST)
	public List<EffectiveHoursData> getEffectiveHours(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("ids") String[] ids) throws ParseException{
				
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		List<EffectiveHoursData> EffectiveHoursDatas = new ArrayList<EffectiveHoursData>();
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());

			for (String id : ids) {
				int parseId = Integer.parseInt(id);
				queryPeriod.setId(parseId);
				EffectiveHoursData data = effectiveHoursService.getEffectiveHours(queryPeriod);
				data.setEffectiveHours(DataAccuracy.keepThree(data.getEffectiveHours()));
				data.setGenwh(DataAccuracy.keepThree(data.getGenwh()));
				EffectiveHoursDatas.add(data);
			}
			return EffectiveHoursDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			
			for (String id : ids) {
				int parseId = Integer.parseInt(id);
				queryPeriod1.setId(parseId);
				EffectiveHoursData data1 = effectiveHoursService.getEffectiveHours(queryPeriod1);
				
				queryPeriod2.setId(parseId);
				EffectiveHoursData data2 = effectiveHoursService.getEffectiveHours(queryPeriod2);
				double hours = data1.getEffectiveHours() + data2.getEffectiveHours();
				hours = DataAccuracy.keepThree(hours);
				double genwh = data1.getGenwh() + data2.getGenwh();
				genwh = DataAccuracy.keepThree(genwh);
				data2.setEffectiveHours(hours);
				data2.setGenwh(genwh);
				EffectiveHoursDatas.add(data2);
			}
			return EffectiveHoursDatas;
		}
		return EffectiveHoursDatas;
	}
}
