package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.AvailabilityData;
import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.SingleMaxPowerData;
import cn.xjfd.ssm.pojo.WindInfo;
import cn.xjfd.ssm.service.AvailabilityService;
import cn.xjfd.ssm.service.AvailabilityService11111;
import cn.xjfd.ssm.service.GetWindInfoService;
import cn.xjfd.ssm.util.DataAccuracy;

@Controller
@RequestMapping("AvailabilityController")
public class AvailabilityController {

	@Autowired
	AvailabilityService availabilityService;
	
	@Autowired
	GetWindInfoService getWindInfoService;
	
	@ResponseBody
	@RequestMapping(value = "getAvailabilityData", method = RequestMethod.POST)
	public List<AvailabilityData> getAvailabilityData(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("ids") String[] ids) throws ParseException{
//		System.out.println(startTimeStr);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startyear = startTimeStr.substring(0, 4);
		String endyear = endTimeStr.substring(0, 4);
		int startyearint = Integer.parseInt(startyear);
		int endyearint = Integer.parseInt(endyear);
		int yearCount = endyearint - startyearint;
		Date startTime = sdf.parse(startTimeStr);
		Date endTime = sdf.parse(endTimeStr);
		List<WindInfo> windInfos = new ArrayList<WindInfo>();
		List<WindInfo> windInfoPool = getWindInfoService.getWindInfo();
		for (String id : ids) {
			int parseId = Integer.parseInt(id);
			for (WindInfo windInfo : windInfoPool) {
				if(parseId == windInfo.getId()) {
					windInfos.add(windInfo);
				}
			}
		}
		List<AvailabilityData> AvailabilityDatas = new ArrayList<AvailabilityData>();
		
		if(yearCount == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(startTime);
			queryPeriod.setEndTime(endTime);
			queryPeriod.setYear(startyearint);

			for (WindInfo windInfo : windInfos) {
				queryPeriod.setId(windInfo.getId());
				FailDownData failDownData = availabilityService.getFailDownTime(queryPeriod);
				AvailabilityData data = new AvailabilityData();
				data.setId(windInfo.getId());
				data.setName(windInfo.getName());
				double failDownTime = failDownData.getFailDownTime() / (1000*60*60);
				failDownTime = DataAccuracy.keepThree(failDownTime);
				data.setFailDownTime(failDownTime);
				double totalTime = (endTime.getTime() - startTime.getTime()) / (1000*60*60);
				totalTime = DataAccuracy.keepThree(totalTime);
				data.setTotalTime(totalTime);
				double availableTime = totalTime - failDownTime;
				data.setAvailableTime(availableTime);
				double availability = (availableTime / totalTime) * 100;
				availability = DataAccuracy.keepThree(availability);
				data.setAvailability(availability);
//				System.out.println(data.getAvailability());
				AvailabilityDatas.add(data);
			}
			return AvailabilityDatas;
		}else if(yearCount == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
//			Date endTime1 = sdf.parse(startyearint + "-12-31 23:59:59");
			queryPeriod1.setStartTime(startTime);
			queryPeriod1.setEndTime(endTime);
			queryPeriod1.setYear(startyearint);
			QueryPeriod queryPeriod2 = new QueryPeriod();
			
			queryPeriod2.setStartTime(startTime);
			queryPeriod2.setEndTime(endTime);
			queryPeriod2.setYear(endyearint);
			
			for (WindInfo windInfo : windInfos) {
				queryPeriod1.setId(windInfo.getId());
				FailDownData failDownData1 = availabilityService.getFailDownTime(queryPeriod1);
//				AvailabilityData data1 = new AvailabilityData();
//				data1.setId(windInfo.getId());
//				data1.setName(windInfo.getName());
//				data1.setFailDownTime(failDownData1.getFailDownTime() / (1000*60*60));
//				data1.setTotalTime((endTime1.getTime() - startTime.getTime()) / (1000*60*60));
//				data1.setAvailableTime(data1.getTotalTime() - data1.getFailDownTime());
//				data1.setAvailability(data1.getAvailableTime() / data1.getTotalTime());
								
				queryPeriod2.setId(windInfo.getId());
				FailDownData failDownData2 = availabilityService.getFailDownTime(queryPeriod2);
				AvailabilityData data2 = new AvailabilityData();
				data2.setId(windInfo.getId());
				data2.setName(windInfo.getName());
				double failDownTime = (failDownData2.getFailDownTime() + failDownData1.getFailDownTime()) / (1000*60*60);
				failDownTime = DataAccuracy.keepThree(failDownTime);
				data2.setFailDownTime(failDownTime);
				double totalTime = (endTime.getTime() - startTime.getTime()) / (1000*60*60);
				totalTime = DataAccuracy.keepThree(totalTime);
				data2.setTotalTime(totalTime);
				double availableTime = totalTime - failDownTime;
				data2.setAvailableTime(availableTime);
				double availability = (availableTime / totalTime) * 100;
				availability = DataAccuracy.keepThree(availability);
				data2.setAvailability(availability);
				AvailabilityDatas.add(data2);
			}
			return AvailabilityDatas;
		}
		return AvailabilityDatas;
	}
}
