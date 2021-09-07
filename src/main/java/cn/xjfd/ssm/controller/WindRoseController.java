package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ScatterWindPowerData;
import cn.xjfd.ssm.pojo.WindRoseData;
import cn.xjfd.ssm.service.WindRoseService;
import cn.xjfd.ssm.util.DataAccuracy;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("WindRoseController")
public class WindRoseController {

	@Autowired
	WindRoseService windRoseService;
	
	@ResponseBody
	@RequestMapping(value = "getWindRoseData", method = RequestMethod.POST)
	public List<WindRoseData> getWindRoseData(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("gid") String gid) throws ParseException{
		List<WindRoseData> windRoseDatas = new ArrayList<WindRoseData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		int parseGid = Integer.parseInt(gid);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());
			queryPeriod.setGid(parseGid);
			windRoseDatas = windRoseService.getWindRoseData(queryPeriod);
			for (int i = 0; i < windRoseDatas.size(); i++) {
				windRoseDatas.get(i).setWindDirectionFrequency(DataAccuracy.keepThree(windRoseDatas.get(i).getWindDirectionFrequency()));
				windRoseDatas.get(i).setWindEnergy(DataAccuracy.keepThree(windRoseDatas.get(i).getWindEnergy()));
			}
			return windRoseDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			queryPeriod1.setGid(parseGid);
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			queryPeriod2.setGid(parseGid);

			List<WindRoseData> data1 = windRoseService.getWindRoseData(queryPeriod1);
			List<WindRoseData> data2 = windRoseService.getWindRoseData(queryPeriod2);
			for (int i = 0; i < data2.size(); i++) {
				for (int j = 0; j < data1.size(); j++) {
					if(data2.get(i).getWindDirectionId() == data1.get(j).getWindDirectionId()) {
						data2.get(i).setAvgWindSpeed(String.valueOf((Double.parseDouble(data2.get(i).getAvgWindSpeed()) + Double.parseDouble(data1.get(j).getAvgWindSpeed())) / 2));
						data2.get(i).setAvgPower(String.valueOf((Double.parseDouble(data2.get(i).getAvgPower()) + Double.parseDouble(data1.get(j).getAvgPower())) / 2));
						data2.get(i).setFrequency(data2.get(i).getFrequency() + data1.get(j).getFrequency());
					}
				}
			}
			int countSum = 0;
			for (int i = 0; i < data2.size(); i++) {
				countSum += data2.get(i).getFrequency();
			}
			if(countSum != 0) {
				for (int i = 0; i < data2.size(); i++) {
					double windDirectionFrequencyTemp = ((double)data2.get(i).getFrequency() * 100) / countSum;
					double windSpeed = Double.parseDouble(data2.get(i).getAvgWindSpeed());
					data2.get(i).setWindDirectionFrequency(windDirectionFrequencyTemp);
					data2.get(i).setWindEnergy(windSpeed * windSpeed * windSpeed * windDirectionFrequencyTemp);
				}
			}
			for (int i = 0; i < data2.size(); i++) {
				data2.get(i).setWindDirectionFrequency(DataAccuracy.keepThree(data2.get(i).getWindDirectionFrequency()));
				data2.get(i).setWindEnergy(DataAccuracy.keepThree(data2.get(i).getWindEnergy()));
			}
		
			return data2;
		}
		
		return windRoseDatas;
	}
}
