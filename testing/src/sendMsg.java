import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sendMsg")
public class sendMsg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("in function");
		String hostname = "localhost";
		int port = 6790;
		int foodTruckId = 1; //temporary
		double latitude = 0;
		double longtitude = 0;
		String name = request.getParameter("foodtruckname");
		System.out.println("PRINT THE NAME: "+ name);
		try{
			System.out.println("Trying to connect to " + hostname + ":" + port);
			Socket s = new Socket(hostname, port);
			InputStreamReader isr = new InputStreamReader(s.getInputStream());
			BufferedReader br = new BufferedReader(isr);
			PrintWriter pw = new PrintWriter (s.getOutputStream());
			pw.println(name);
			pw.flush();
		}catch (IOException ioe){
			System.out.println("unable to send msg");
		}
	}

	

}
