package cn.xjfd.ssm.service.Impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.WindRoseMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindRoseData;
import cn.xjfd.ssm.service.WindRoseService;
@Service
public class WindRoseServiceImpl implements WindRoseService{

	
	@Autowired
	WindRoseMapper windRoseMapper;
	
	@Override
	public List<WindRoseData> getWindRoseData(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		List<WindRoseData> windRoseDatas = windRoseMapper.getWindRoseData(queryPeriod);
		if(windRoseDatas.size() != 0) {
			int countSum = 0;
			for (int i = 0; i < windRoseDatas.size(); i++) {
				countSum += windRoseDatas.get(i).getFrequency();
			}
			for (int i = 0; i < windRoseDatas.size(); i++) {
				if(countSum != 0) {
					double windDirectionFrequencyTemp = ((double)windRoseDatas.get(i).getFrequency() * 100) / countSum;
					double windSpeed = Double.parseDouble(windRoseDatas.get(i).getAvgWindSpeed());
					windRoseDatas.get(i).setWindDirectionFrequency(windDirectionFrequencyTemp);
					windRoseDatas.get(i).setWindEnergy(windSpeed * windSpeed * windSpeed * windDirectionFrequencyTemp);
				}
				
				switch (windRoseDatas.get(i).getWindDirectionId()) {
				case 1:
					windRoseDatas.get(i).setWindDirection("-11.25°~11.25°");
					break;
				case 2:
					windRoseDatas.get(i).setWindDirection("11.25°~33.75°");
					break;
				case 3:
					windRoseDatas.get(i).setWindDirection("33.75°~56.25°");
					break;
				case 4:
					windRoseDatas.get(i).setWindDirection("56.25°~78.75°");
					break;
				case 5:
					windRoseDatas.get(i).setWindDirection("78.75°~101.25°");
					break;
				case 6:
					windRoseDatas.get(i).setWindDirection("101.25°~123.75°");
					break;
				case 7:
					windRoseDatas.get(i).setWindDirection("123.75°~146.25°");
					break;
				case 8:
					windRoseDatas.get(i).setWindDirection("146.25°~168.75°");
					break;
				case 9:
					windRoseDatas.get(i).setWindDirection("168.75°~191.25°");
					break;
				case 10:
					windRoseDatas.get(i).setWindDirection("191.25°~213.75°");
					break;
				case 11:
					windRoseDatas.get(i).setWindDirection("213.75°~236.25°");
					break;
				case 12:
					windRoseDatas.get(i).setWindDirection("236.25°~258.75°");
					break;
				case 13:
					windRoseDatas.get(i).setWindDirection("258.75°~281.25°");
					break;
				case 14:
					windRoseDatas.get(i).setWindDirection("281.25°~303.75°");
					break;
				case 15:
					windRoseDatas.get(i).setWindDirection("303.75°~326.25°");
					break;
				case 16:
					windRoseDatas.get(i).setWindDirection("326.25°~348.75°");
					break;
				default:
					break;
				}
			}
		}
		
		return windRoseDatas;
	}

}
