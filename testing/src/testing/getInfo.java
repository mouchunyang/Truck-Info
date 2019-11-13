package testing;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class getInfo
 */
@WebServlet("/getInfo")
public class getInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Here inside of getInfo");
		String sunday = request.getParameter("Sunday");
		String monday = request.getParameter("Monday");
		String tuesday = request.getParameter("Tuesday");
		String wednesday = request.getParameter("Wednesday");
		String thursday = request.getParameter("Thursday");
		String friday = request.getParameter("Friday");
		String saturday = request.getParameter("Saturday");
		
		String hoursStr = sunday + "|" +  monday + "|" + tuesday + "|" + wednesday + "|" + thursday + "|" + friday + "|" + saturday;
		
		//5:00am-9:00pm | 
		String addressStr = request.getParameter("food truck address");
		
		float latFlt = (float) 0.0;
		float lonFlt = (float) 0.0;
		
		
		String username = request.getParameter("username");
		String ftname= request.getParameter("food truck name");
		
		  Map<String, String[]> f = request.getParameterMap();
		  String[] foodItems = f.get("fooditem");
		  Map<String, String[]> fp = request.getParameterMap();
		  String[] foodPrices = fp.get("foodprice");
		  String dbFoodItemStr = "";
		  for (int i = 0; i < foodItems.length; i++)
		  {
			  dbFoodItemStr += (foodItems[i] + "-" +  foodPrices[i] + "-");
		  }
		  System.out.println("food items are " + dbFoodItemStr);
		  Map<String, String[]> b = request.getParameterMap();
		  String[] bevItems = b.get("fooditem");
		  Map<String, String[]> bp = request.getParameterMap();
		  String[] bevPrices = bp.get("foodprice");
		  String dbBevItemStr = "";
		  for (int i = 0; i < bevItems.length; i++)
		  {
			  dbBevItemStr += (bevItems[i] + "-" + bevPrices[i] + "-");
		  }
		  System.out.println("bev items are " + dbBevItemStr);
		  
		  QueryDatabase ds = new QueryDatabase();
		  if (ds.addTruck(username, ftname, dbFoodItemStr, dbBevItemStr, hoursStr, addressStr, latFlt, lonFlt))
			  //need to go back to home now 
			System.out.println("YASSSSSS");
		  else
		  {
			  request.getSession().setAttribute("error", "One or more fields were not entered. Please fill all fields");
			  RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/ftoinfo.jsp");
			  dispatch.forward(request, response);
		  }
		  
//addTruck(String username, String name, String menu, String bevs, String hours, String address, float latitude, float longitude)
		  
		  
	//		Map<String, String[]> m = request.getParameterMap(); 
//		Set<Map.Entry<String,String[]>> set = m.entrySet();
//	    Iterator it = set.iterator();
//	    while (it.hasNext()) {
//	      @SuppressWarnings("unchecked")
//		Map.Entry<String, String[]> entry = 
//	                (Entry<String, String[]>) it.next();
//	      String paramName = entry.getKey();
//	      if (paramName == "fooditem")
//	    	  System.out.println("food!");
//	    }
//		
		
		
	}

}
