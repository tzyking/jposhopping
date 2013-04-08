package com.bjsxt.shopping.util;

public class StringReplacer {
	
	public static String emptySpaceFixer(String input)
	{
		return input.replaceAll("[^A-Za-z0-9]", " ").replaceAll(" +", " ").replace(" ", "_");
	}
	

	public static void main(String[] args) {
			// TODO Auto-generated method stub
			System.out.println(StringReplacer.emptySpaceFixer("GREY MELANGE"));
			System.out.println(StringReplacer.emptySpaceFixer("TEST AUGUST 3-2012"));
			System.out.println("tzyking".contains(" "));
		}
}
