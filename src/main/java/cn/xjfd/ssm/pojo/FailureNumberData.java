package cn.xjfd.ssm.pojo;

public class FailureNumberData {

	private int id;
	private String name;
	private int failureNumber;
	
	public FailureNumberData(int id, String name, int failureNumber) {
		super();
		this.id = id;
		this.name = name;
		this.failureNumber = failureNumber;
	}

	public FailureNumberData() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getFailureNumber() {
		return failureNumber;
	}

	public void setFailureNumber(int failureNumber) {
		this.failureNumber = failureNumber;
	}
	
	
}
