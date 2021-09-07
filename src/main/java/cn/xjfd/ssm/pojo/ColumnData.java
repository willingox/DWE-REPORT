package cn.xjfd.ssm.pojo;

public class ColumnData {

	private String columndes;
	private String columnname;
	
	
	public ColumnData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ColumnData(String columndes, String columnname) {
		super();
		this.columndes = columndes;
		this.columnname = columnname;
	}
	public String getColumndes() {
		return columndes;
	}
	public void setColumndes(String columndes) {
		this.columndes = columndes;
	}
	public String getColumnname() {
		return columnname;
	}
	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}
	
	
}
