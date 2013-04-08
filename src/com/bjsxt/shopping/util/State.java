package com.bjsxt.shopping.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class State {
	private String abbreviation; 
	private String name; 
	
	

	public String getAbbreviation() {
		return abbreviation;
	}
	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public static List getStates()
	  {
	    List States = new ArrayList();
	    Connection conn = DB.getConn();
	    String sql = "select * from states";
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = DB.getResultSet(stmt, sql);
	    try {
	      while (rs.next()) {
	        State s = new State();
	        s.setAbbreviation(rs.getString("abbreviation"));
	        s.setName(rs.getString("name"));
	        States.add(s);
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return States;
	  }
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List States = State.getStates();
		System.out.println(States.size());

	}

}
