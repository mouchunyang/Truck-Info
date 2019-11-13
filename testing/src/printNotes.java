
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


@WebServlet("/printNotes")
public class printNotes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hostname = "localHost";
		int port =  6790;
		System.out.println("in get method");
		try {
			System.out.println("Trying to connect to " + hostname + ":" + port);
			Socket s = new Socket(hostname, port);
			InputStreamReader isr = new InputStreamReader(s.getInputStream());
			BufferedReader br = new BufferedReader(isr);
			PrintWriter pw = response.getWriter();
			while(true) { //TODO change to loggedIn User is null
		    	//get Messages from server, 
		    	//The message's format should be: food truck's Id | latitude | longtitude
		    	String line = br.readLine();
		    	//System.out.println("received" + line); //debug
		    	//String[] data = line.split("\\|");
		    	//int foodTruckId = Integer.parseInt(data[0].trim());
		    	//double newTruckLat = Double.parseDouble(data[1].trim());
		    	//double newTruckLon = Double.parseDouble(data[2].trim());
		    	//if the truck in within a distance - TODO LATER
		    	//pop out a window and direct the user to another page
	            pw.println(line);
	            pw.flush();
	            pw.close();
		    }
		}catch(IOException ioe) {
			System.out.println("Unable to connect to server");
		}
	}	
}

