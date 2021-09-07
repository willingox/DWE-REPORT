package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.OperatRecordData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface OperatRecordService {

	public List<OperatRecordData> getOperatRecord(QueryPeriod queryPeriod);
}
