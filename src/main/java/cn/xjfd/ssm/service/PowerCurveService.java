package cn.xjfd.ssm.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.xjfd.ssm.pojo.PowerCurveActual;
import cn.xjfd.ssm.pojo.PowerCurveStandard;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface PowerCurveService {

	List<PowerCurveStandard> getPowerCurveStandard(QueryPeriod queryPeriod);
	
	List<PowerCurveActual> getPowerCurveActual(QueryPeriod queryPeriod);
}
