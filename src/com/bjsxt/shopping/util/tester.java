package com.bjsxt.shopping.util;

public class tester {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int Min = 1, Max;
		Max = 6;
		int randomIndex = Min + (int)(Math.random() * ((Max - Min) + 1));  
		
			System.out.println(randomIndex);

	}

}
