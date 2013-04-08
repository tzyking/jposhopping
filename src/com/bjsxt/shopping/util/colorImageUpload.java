package com.bjsxt.shopping.util;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.*;

import java.util.*;
import java.util.regex.*;
import java.io.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;


public class colorImageUpload extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public colorImageUpload() {
		super();
	}

	//private String uploadPath_listItem = "U:\\listItem\\";
	//private String uploadPath_zoomItem = "U:\\zoomItem\\";
	//private String uploadPath_thumbItem = "U:\\thumbItem\\";

	//private File tempPath = new File("U:\\TEMP\\");

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//int id = -1;
		String colorName = "";
		ServletContext context = getServletContext();
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(4096);
		// the location for saving data that is larger than getSizeThreshold()
		
		//factory.setRepository(new File("D:\\temp\\"));
		factory.setRepository(new File(context.getRealPath("/")+"temp"));
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		upload.setSizeMax(3000000);

		try {
			List fileItems = upload.parseRequest(request);
			// assume we know there are two files. The first file is a small
			// text file, the second is unknown and is written to a file on
			// the server
			Iterator iter = fileItems.iterator();

			String regExp = ".+\\\\(.+)$";

			String[] errorType = { ".exe", ".com", ".cgi", ".jsp" };
			Pattern p = Pattern.compile(regExp);
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					if (item.getFieldName().equals("colorName")) {
						colorName = item.getString();
					}
				}

				if (!item.isFormField()) {
					String name = item.getName();
					String uploadPath = "";
					//if(item.getFieldName().equals("zoomItem_b"))
					//	uploadPath = context.getRealPath("/") + "pic"+File.separator+"zoomItem"+File.separator +  id + "b.jpg";
					//else
						uploadPath = context.getRealPath("/") + "pic"+File.separator + item.getFieldName()+File.separator +  colorName + ".jpg";
					
					System.out.println(item.getFieldName());
					
					long size = item.getSize();
					if ((name == null || name.equals("")) && size == 0)
						continue;
					Matcher m = p.matcher(name);
					boolean result = m.find();
					result = true;
					System.out.println("before if");
					if (result) {
						//for (int temp = 0; temp < errorType.length; temp++) {
						//	if (m.group(1).endsWith(errorType[temp])) {
						//		throw new IOException(name + ": wrong type");
						//	}
						//}
						try {
							System.out.println("attain");
							item.write(new File(uploadPath));
							

							out.print(uploadPath + "&nbsp;&nbsp;" + size + "<br>");
							response.sendRedirect("../admin/colorList.jsp");
						} catch (Exception e) {
							out.println(e);
						}

					} else {
						System.out.println("before fail to upload");
						throw new IOException("fail to upload");
					}
				}
			}
		} catch (IOException e) {
			out.println(e);
		} catch (FileUploadException e) {
			out.println(e);
		}

	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		
	}

}
