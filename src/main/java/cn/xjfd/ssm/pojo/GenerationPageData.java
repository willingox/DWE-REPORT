package cn.xjfd.ssm.pojo;

import java.util.Date;

public class GenerationPageData {

	private int id;
	private String name;
	private double genwh;
	private double genHour;

	
	
	public GenerationPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public GenerationPageData(int id, String name, double genwh, double genHour) {
		super();
		this.id = id;
		this.name = name;
		this.genwh = genwh;
		this.genHour = genHour;
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


	public double getGenwh() {
		return genwh;
	}


	public void setGenwh(double genwh) {
		this.genwh = genwh;
	}


	public double getGenHour() {
		return genHour;
	}


	public void setGenHour(double genHour) {
		this.genHour = genHour;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.getId() +"\t"+ this.getName()+"\t"+ this.getGenwh()+"\t"+ this.getGenHour();
	}
	
}
