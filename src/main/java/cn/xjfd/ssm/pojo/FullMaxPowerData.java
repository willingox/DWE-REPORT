package cn.xjfd.ssm.pojo;

public class FullMaxPowerData {

	private double fullmaxCurp;
	private double fullmaxCurpWind;
	private String fullmaxCurpTime;
	
	
	
	public FullMaxPowerData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FullMaxPowerData(double fullmaxCurp, double fullmaxCurpWind, String fullmaxCurpTime) {
		super();
		this.fullmaxCurp = fullmaxCurp;
		this.fullmaxCurpWind = fullmaxCurpWind;
		this.fullmaxCurpTime = fullmaxCurpTime;
	}
	public double getFullmaxCurp() {
		return fullmaxCurp;
	}
	public void setFullmaxCurp(double fullmaxCurp) {
		this.fullmaxCurp = fullmaxCurp;
	}
	public double getFullmaxCurpWind() {
		return fullmaxCurpWind;
	}
	public void setFullmaxCurpWind(double fullmaxCurpWind) {
		this.fullmaxCurpWind = fullmaxCurpWind;
	}
	public String getFullmaxCurpTime() {
		return fullmaxCurpTime;
	}
	public void setFullmaxCurpTime(String fullmaxCurpTime) {
		this.fullmaxCurpTime = fullmaxCurpTime;
	}
	
	
}
