package cn.xjfd.ssm.pojo;

public class PowerCurveActual {

	private String windvelval;
	private double curp;
	
	
	
	
	public PowerCurveActual() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PowerCurveActual(String windvelval, double curp) {
		super();
		this.windvelval = windvelval;
		this.curp = curp;
	}
	
	public String getWindvelval() {
		return windvelval;
	}
	public void setWindvelval(String windvelval) {
		this.windvelval = windvelval;
	}
	public double getCurp() {
		return curp;
	}
	public void setCurp(double curp) {
		this.curp = curp;
	}
	
	
}
