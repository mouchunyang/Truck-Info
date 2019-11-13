package testing;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class GetInfoFromDb
 */
@WebServlet("/GetInfoFromDb")
public class GetInfoFromDb extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetInfoFromDb() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		System.out.println("HERE");
		if (request.getSession(false)== null)
		{
			System.out.println("Here");
		}
		else
		{
			String truckname = "";
			String foodMenu = "";
			String beverages = "";
			String hours = "";
			String address = "";
			Float latitude = .01f;
			Float longitude = .01f;
			Float rating = .01f;
			String monday = "";
			String tuesday = "";
			String wednesday = "";
			String thursday = "";
			String friday = "";
			String sunday = "";
			String saturday = "";
			List<String> foodItems = new ArrayList<>();
			List<String> bevItems = new ArrayList<>();
			List<String> foodPrices = new ArrayList<>();
			List<String> bevPrices = new ArrayList<>();
			List<String> hrs = new ArrayList<>();
			
			QueryDatabase db;
			try {
				db = QueryDatabase.getInstance();
				System.out.println("user name is " + request.getSession(false).getAttribute("username"));
				String username = "";
				if (request.getParameter("username") != null){
				    username = request.getParameter("username");
				}
				else{
					username = (String) request.getSession(false).getAttribute("username");
				}
				if (db.getUserID(username) > 0)
				{
					try {
						Connection conn = db.getConnection();
						java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM TruckInfo, Users WHERE truckID = ?");
						ps.setInt(1, db.getUserID(username));
						ResultSet rs = ps.executeQuery();
						while (rs.next()) {
						truckname = rs.getString("truckName");
						foodMenu = rs.getString("foodMenu");
						beverages = rs.getString("beverages");
						hours = rs.getString("hours");
						address = rs.getString("address");
						latitude = rs.getFloat("latitude");
						longitude = rs.getFloat("longitude");
						rating = rs.getFloat("rating");
						}
					}catch(SQLException e)
					{
						
					}
					
					foodItems = new ArrayList<>();
					StringTokenizer st = new StringTokenizer(foodMenu, "-");
				     while (st.hasMoreTokens()) {
				         foodItems.add(st.nextToken());
				     }
				     for (int i = 0; i < foodItems.size(); i++)
				     {
				    	 if (i%2 == 1)
				    		 foodPrices.add(foodItems.get(i));
				     }
				     
					
					bevItems = new ArrayList<>();
					StringTokenizer st2 = new StringTokenizer(beverages, "-");
				     while (st2.hasMoreTokens()) {
				         bevItems.add(st2.nextToken());
				     }
				     for (int i = 0; i < bevItems.size(); i++)
				     {
				    	 if (i%2 == 1)
				    		 bevPrices.add(bevItems.get(i));
				     }
				     
					
					hrs = new ArrayList<>();
					StringTokenizer st3 = new StringTokenizer(hours, "|");
					System.out.println(hours);
				     while (st3.hasMoreTokens()) {
				         hrs.add(st3.nextToken());
				         System.out.print("token");
				     }
				    sunday = hrs.get(0);
				    monday = hrs.get(1);
				    tuesday = hrs.get(2);
				    wednesday = hrs.get(3);
				    thursday = hrs.get(4);
				    friday = hrs.get(5);
				    saturday = hrs.get(6);
					
				
					
				}
				
				request.getSession().setAttribute("sunday", sunday);
				request.getSession().setAttribute("monday", monday);
				request.getSession().setAttribute("tuesday", tuesday);
				request.getSession().setAttribute("wednesday", wednesday);
				request.getSession().setAttribute("thursday", thursday);
				request.getSession().setAttribute("friday", friday);
				request.getSession().setAttribute("saturday", saturday);
				request.getSession().setAttribute("truckname", truckname);
				request.getSession().setAttribute("address", address);
				request.getSession().setAttribute("lat", latitude);
				request.getSession().setAttribute("lon", longitude);
				request.getSession().setAttribute("rating", rating);
				System.out.println("FoodItemArr is set");
				request.getSession().setAttribute("foodItemArr", foodItems);
				System.out.println(request.getAttribute("foodItemArr"));
				request.getSession().setAttribute("bevItemArr", bevItems);
				request.getSession().setAttribute("foodPriceArr", foodPrices);
				request.getSession().setAttribute("bevPriceArr", bevPrices);
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			
			//QueryDatabase db = (QueryDatabase) request.getSession(false).getAttribute("db");
			
			
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/ftoeditinfo.jsp");
			dispatch.forward(request, response);
			

			
		}
		
	
	}

}

