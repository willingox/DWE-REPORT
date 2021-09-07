package cn.xjfd.ssm.pojo;

public class HisImportantData {

	private String savetime;
	private double cal0;
	private double cal1;
	private double cal2;
	private double cal3;
	private double cal4;
	
	
	
	public HisImportantData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HisImportantData(String savetime, double cal0, double cal1, double cal2, double cal3, double cal4) {
		super();
		this.savetime = savetime;
		this.cal0 = cal0;
		this.cal1 = cal1;
		this.cal2 = cal2;
		this.cal3 = cal3;
		this.cal4 = cal4;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public double getCal0() {
		return cal0;
	}
	public void setCal0(double cal0) {
		this.cal0 = cal0;
	}
	public double getCal1() {
		return cal1;
	}
	public void setCal1(double cal1) {
		this.cal1 = cal1;
	}
	public double getCal2() {
		return cal2;
	}
	public void setCal2(double cal2) {
		this.cal2 = cal2;
	}
	public double getCal3() {
		return cal3;
	}
	public void setCal3(double cal3) {
		this.cal3 = cal3;
	}
	public double getCal4() {
		return cal4;
	}
	public void setCal4(double cal4) {
		this.cal4 = cal4;
	}
	
	
}
