package cn.xjfd.ssm.util;

public class DataAccuracy {

	public static double keepThree(double num) {
		return (double)Math.round(num*1000)/1000;
	}
}
