package testing;


import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DataServlet
 */
@WebServlet("/DataServlet")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("data servlet reached");
		Vector <TruckInfo> trucks = new Vector<TruckInfo>();
		QueryDatabase qd = new QueryDatabase();
		trucks = qd.getAllInfo();
		System.out.println("TRUCKS size from data servlet is " + trucks.size());
		HttpSession session = request.getSession();
		session.setAttribute("TruckInfo", trucks);
		request.setAttribute("TruckInfo", trucks);
		RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
		rd.forward(request, response);
		System.out.println("Data Servlet done");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
