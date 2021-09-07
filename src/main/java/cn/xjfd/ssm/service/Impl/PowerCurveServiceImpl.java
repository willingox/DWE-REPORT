package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.PowerCurveMapper;
import cn.xjfd.ssm.pojo.PowerCurveActual;
import cn.xjfd.ssm.pojo.PowerCurveStandard;
import cn.xjfd.ssm.pojo.QueryPeriod;
@Service
public class PowerCurveServiceImpl implements cn.xjfd.ssm.service.PowerCurveService{

	@Autowired
	PowerCurveMapper powerCurveMapper;
	
	@Override
	public List<PowerCurveStandard> getPowerCurveStandard(QueryPeriod queryPeriod) {
		
		return powerCurveMapper.getPowerCurveStandard(queryPeriod);
	}

	@Override
	public List<PowerCurveActual> getPowerCurveActual(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return powerCurveMapper.getPowerCurveActual(queryPeriod);
	}

}
