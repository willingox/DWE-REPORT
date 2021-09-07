package cn.xjfd.ssm.pojo;

public class FanStateData {

	private String NAME;
	private String plcState;
	private String curTime;
	private String endTime;
	
	
	public FanStateData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FanStateData(String nAME, String plcState, String curTime, String endTime) {
		super();
		NAME = nAME;
		this.plcState = plcState;
		this.curTime = curTime;
		this.endTime = endTime;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getPlcState() {
		return plcState;
	}
	public void setPlcState(String plcState) {
		this.plcState = plcState;
	}
	public String getCurTime() {
		return curTime;
	}
	public void setCurTime(String curTime) {
		this.curTime = curTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	
}
