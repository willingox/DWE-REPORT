package cn.xjfd.ssm.pojo;

public class OperatRecordData {

	private String name;
	private String control;
	private String operat;
	
	private String operator;
	private String savetime;
	
	public OperatRecordData(String control, String operat, String savetime, String operator, String name) {
		super();
		this.control = control;
		this.operat = operat;
		this.savetime = savetime;
		this.operator = operator;
		this.name = name;
	}
	public OperatRecordData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getControl() {
		return control;
	}
	public void setControl(String control) {
		this.control = control;
	}
	public String getOperat() {
		return operat;
	}
	public void setOperat(String operat) {
		this.operat = operat;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
