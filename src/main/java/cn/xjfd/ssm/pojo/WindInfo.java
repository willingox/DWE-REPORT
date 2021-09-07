package cn.xjfd.ssm.pojo;

public class WindInfo {

	private int id;
	private String name;
	private int gid;
	
	
	public WindInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WindInfo(int id, String name, int gid) {
		super();
		this.id = id;
		this.name = name;
		this.gid = gid;
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
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	
	
}
