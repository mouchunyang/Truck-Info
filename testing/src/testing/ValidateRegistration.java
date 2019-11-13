package testing;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ValidateRegistration
 */
@WebServlet("/ValidateRegistration")
public class ValidateRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
System.out.println("Here inside of the right servlet");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm = request.getParameter("re-password");
	
		String goTo="";
		boolean loginResult = false;
		
		QueryDatabase ds;

		ds = new QueryDatabase();
		int id = ds.getUserID(username);
		if (id != 0)
		{
			String userE = "Username already exists.";
			request.getSession().setAttribute("error", userE);
			goTo = "/ftoregister.jsp";
		}
		else
		{
			String conflictPass = "";
			if (confirm == null) {
				confirm = "";
			}
			
			if (confirm.equals(password))
			{
				if (ds.addUser(username, password))
				{
					goTo = "/ftoinfo.jsp";
					request.getSession().setAttribute("error", "");
				}
				else
				{
					request.getSession().setAttribute("error", "Insertion error");
					goTo = "/ftoregister.jsp";
				}
			}
			else
			{
				conflictPass = "Passwords dont match";
				goTo = "/ftoregister.jsp";
				request.getSession().setAttribute("error", conflictPass);
			}

		} 
		request.getSession().setAttribute("db", ds);

		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(goTo);
		dispatch.forward(request, response);
	}

}

