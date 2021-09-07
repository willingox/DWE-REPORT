package cn.xjfd.ssm.pojo;

public class PowerCurveData {

	private String windvelval;
	private double genpwd;
	private double curp;
	
	
	public PowerCurveData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PowerCurveData(String windvelval, double genpwd, double curp) {
		super();
		this.windvelval = windvelval;
		this.genpwd = genpwd;
		this.curp = curp;
	}
	public String getWindvelval() {
		return windvelval;
	}
	public void setWindvelval(String windvelval) {
		this.windvelval = windvelval;
	}
	public double getGenpwd() {
		return genpwd;
	}
	public void setGenpwd(double genpwd) {
		this.genpwd = genpwd;
	}
	public double getCurp() {
		return curp;
	}
	public void setCurp(double curp) {
		this.curp = curp;
	}
	
	
}
