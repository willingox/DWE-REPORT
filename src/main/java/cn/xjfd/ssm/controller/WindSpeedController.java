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
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindSpeedData;
import cn.xjfd.ssm.service.WindSpeedService;
import cn.xjfd.ssm.util.DataAccuracy;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("WindSpeedController")
public class WindSpeedController {

	@Autowired
	WindSpeedService windSpeedService;
	
	@ResponseBody
	@RequestMapping(value = "getWindSpeed", method = RequestMethod.POST)
	public List<WindSpeedData> getWindSpeed(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("gids") String[] gids) throws ParseException{
		List<WindSpeedData> windSpeedDatas = new ArrayList<WindSpeedData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());

			for (String gid : gids) {
				int parseGid = Integer.parseInt(gid);
				queryPeriod.setGid(parseGid);
				WindSpeedData data = windSpeedService.getWindSpeed(queryPeriod);
				data.setAvgWind(DataAccuracy.keepThree(data.getAvgWind()));
				data.setMaxWind(DataAccuracy.keepThree(data.getMaxWind()));
				data.setMinWind(DataAccuracy.keepThree(data.getMinWind()));
				windSpeedDatas.add(data);
			}
			return windSpeedDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			
			for (String gid : gids) {
				int parseGid = Integer.parseInt(gid);
				queryPeriod1.setGid(parseGid);
				WindSpeedData data1 = windSpeedService.getWindSpeed(queryPeriod1);
				data1.setAvgWind(DataAccuracy.keepThree(data1.getAvgWind()));
				data1.setMaxWind(DataAccuracy.keepThree(data1.getMaxWind()));
				data1.setMinWind(DataAccuracy.keepThree(data1.getMinWind()));
				
				queryPeriod2.setGid(parseGid);
				WindSpeedData data2 = windSpeedService.getWindSpeed(queryPeriod2);
				data2.setAvgWind(DataAccuracy.keepThree(data2.getAvgWind()));
				data2.setMaxWind(DataAccuracy.keepThree(data2.getMaxWind()));
				data2.setMinWind(DataAccuracy.keepThree(data2.getMinWind()));
				
				if(data1.getAvgWind() > 0) {
					double avgWind = (data1.getAvgWind() + data2.getAvgWind()) / 2;
					avgWind = DataAccuracy.keepThree(avgWind);
					data2.setAvgWind(avgWind);
				}
				if(data1.getMaxWind() > data2.getMaxWind()) {
					data2.setMaxTime(data1.getMaxTime());
					data2.setMaxWind(data1.getMaxWind());
				}
				if(data1.getMinWind() < data2.getMinWind()) {
					data2.setMinTime(data1.getMinTime());
					data2.setMinWind(data1.getMinWind());
				}
				windSpeedDatas.add(data2);
			}
			return windSpeedDatas;
		}
		
		return windSpeedDatas;
	}
	
}
