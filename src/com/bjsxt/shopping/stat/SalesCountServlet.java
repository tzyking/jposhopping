package com.bjsxt.shopping.stat;

import com.bjsxt.shopping.util.PropertyMgr;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

public class SalesCountServlet extends HttpServlet
{
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    System.out.println("ok");
    CategoryDataset dataset = getDataSet();
    String fileName = "SalesCount.jpg";
    JFreeChart chart = ChartFactory.createBarChart3D("", 
      "", 
      "", 
      dataset, 
      PlotOrientation.VERTICAL, 
      true, 
      false, 
      false);

    FileOutputStream fos_jpg = null;
    try
    {
      fos_jpg = new FileOutputStream(
        PropertyMgr.getProperty("statImagePath") + fileName);
      System.out.println(PropertyMgr.getProperty("statImagePath"));

      ChartUtilities.writeChartAsJPEG(fos_jpg, 0.5F, chart, 400, 300, 
        null);
    } finally {
      try {
        fos_jpg.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    request.setAttribute("imgName", fileName);
    getServletContext().getRequestDispatcher("/admin/SalesCount.jsp")
      .forward(request, response);
  }

  private CategoryDataset getDataSet()
  {
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();
    List items = StatService.getProductsBySaleCount();
    for (int i = 0; i < items.size(); i++) {
      ProductStatItem p = (ProductStatItem)items.get(i);
      dataset.addValue(p.getTotalSalesCount(), "", p.getProductName());
    }
    return dataset;
  }
}