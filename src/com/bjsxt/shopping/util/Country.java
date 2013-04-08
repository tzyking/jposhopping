package com.bjsxt.shopping.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Country {
	private int id; 
	private String country; 
	private String iso2; 
	private String iso3; 
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}


	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public String getIso2() {
		return iso2;
	}


	public void setIso2(String iso2) {
		this.iso2 = iso2;
	}


	public String getIso3() {
		return iso3;
	}


	public void setIso3(String iso3) {
		this.iso3 = iso3;
	}

	public static List getCountries()
	  {
	    List countries = new ArrayList();
	    Connection conn = DB.getConn();
	    String sql = "select * from countries";
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = DB.getResultSet(stmt, sql);
	    try {
	      while (rs.next()) {
	        Country c = new Country();
	        c.setId(rs.getInt("id"));
	        c.setCountry(rs.getString("country"));
	        c.setIso2(rs.getString("iso2"));
	        c.setIso3(rs.getString("iso3"));
	        countries.add(c);
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return countries;
	  }

	public static void main(String[] args) {
		List cl = Country.getCountries();
		Country c = (Country)cl.get(0); 
		System.out.println(c.getCountry());
		// TODO Auto-generated method stub

	}

}
