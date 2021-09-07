package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.OperatRecordData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface OperatRecordMapper {

	public List<OperatRecordData> getOperatRecord(QueryPeriod queryPeriod);
}
