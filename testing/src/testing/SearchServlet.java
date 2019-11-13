package testing;

import java.io.IOException;
import java.util.HashSet;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* assuming the search field we send is called food*/
		String searchQuery = request.getParameter("SearchQuery");
		QueryDatabase qd = new QueryDatabase();
		Vector<TruckInfo> trucks = qd.getAllInfo();
		HashSet<TruckInfo> results = new HashSet<TruckInfo>();
		System.out.println("trucks size is " + trucks.size());
		for (int i = 0; i < trucks.size(); ++i) {
			String tempFood = trucks.get(i).getFoodMenu();
			String tempName = trucks.get(i).getTruckName();
			System.out.println(tempFood);
			if (tempFood.contains(searchQuery) || tempName.contains(searchQuery)) {
				results.add(trucks.get(i));
			}
		}
		request.getSession().setAttribute("resultSet", results);
		// no results 
		if (results.size() == 0) {
			request.getSession().setAttribute("errorSearch", "No results found");
			RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
			rd.forward(request, response);
//			RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
//			rd.forward(request, response);
		}
		else { // successful search -- MODIFY WITH NAME OF SEARCH RESULTS PAGE
			request.getSession().setAttribute("errorSearch", "");
		}
		RequestDispatcher rd = request.getRequestDispatcher("searchResults.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
