package testing;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 

/**
 * Servlet implementation class ValidateLogin
 */
@WebServlet("/ValidateLogin")
public class ValidateLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("Here inside of the right servlet");
		request.getSession().setAttribute("currUser", "");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		request.getSession().setAttribute("username", username);
		request.getSession().setAttribute("password", password);
		
	
		String goTo="";
		boolean loginResult = false;
		
		//QueryDatabase ds;

		QueryDatabase ds;
		try {
			ds = QueryDatabase.getInstance();
			int id = ds.getUserID(username);
			if (id == 0)
			{
				String userDNE = "Username does not exist.";
				request.getSession().setAttribute("error", userDNE);
				goTo = "/ftologin.jsp";
			}
			else
			{
				System.out.println("Here trynig to check password");
				loginResult = ds.validateLogin(username, password);
				if (!loginResult)
				{
					String wrongPass = "Incorrect Password.";
					request.getSession().setAttribute("error", wrongPass);
//					PrintWriter pw = response.getWriter();
//					pw.println(wrongPass);
//					pw.flush();
					goTo = "/ftologin.jsp";
				}
				else
				{
					request.getSession().setAttribute("currUser", username);
					request.getSession().setAttribute("error", "");
					
					goTo = "/GetInfoFromDb";
				}
			
			} 
		}catch(SQLException e)
		{
			
		}
		
//		System.out.println("setting db into session here");
//		request.getSession().setAttribute("db", ds);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(goTo);
		dispatch.forward(request, response);
		
	}		
		
}
