package com.bjsxt.shopping.util;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.bjsxt.shopping.homepage.picsNumber;
import com.bjsxt.shopping.homepage.picsOrder;



public class homepagePicUpload extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	
	//private ServletContext context;

	public homepagePicUpload() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
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

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	//request.getRealPath("/");
	//System.out.println("enter");
	ServletContext context = getServletContext();
	//System.out.println("after context");
	
	PrintWriter out = response.getWriter();
	DiskFileItemFactory factory = new DiskFileItemFactory();
	// maximum size that will be stored in memory
	factory.setSizeThreshold(4096);
	// the location for saving data that is larger than getSizeThreshold()
	//factory.setRepository(new File("/usr/share"));
	factory.setRepository(new File(context.getRealPath("/")+"temp"));
	ServletFileUpload upload = new ServletFileUpload(factory);
	// maximum size before a FileUploadException will be thrown
	upload.setSizeMax(3000000);
	System.out.println(context.getRealPath("/"));
	String category = "";
	
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
				if (item.getFieldName().equals("category")) {
					category = item.getString();
				}
			}
	
			if (!item.isFormField()) {
				
				String name = item.getName();
				String uploadPath = "";
				
				//uploadPath =  context.getRealPath("/") + "sample_files/"+ category +"/"+item.getFieldName() + ".jpg";
				uploadPath =  context.getRealPath("/") + "sample_files"+File.separator+ category +File.separator+item.getFieldName() + ".jpg";
				
				System.out.println("upload Path: " + uploadPath);
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
						
						if(!item.getFieldName().startsWith("b")){
							picsNumber.updateCurrentNumberByCategoryName(category);
							String currentorder = picsOrder.getCurrentOrderByCategoryName(category);
							picsOrder.updateCurrentOrderbyCategoryName(currentorder + "," + item.getFieldName(), category);
						}
						//request.getRequestDispatcher ("../admin/homepage/deletePics.jsp?category="+category). forward (request, response); 
						response.sendRedirect("../admin/homepage/deletePics.jsp?category="+category);
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
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		
	}
}
