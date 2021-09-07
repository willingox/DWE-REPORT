package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.PowerCurveActual;
import cn.xjfd.ssm.pojo.PowerCurveStandard;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface PowerCurveMapper {

	List<PowerCurveStandard> getPowerCurveStandard(QueryPeriod queryPeriod);
	
	List<PowerCurveActual> getPowerCurveActual(QueryPeriod queryPeriod);
}
