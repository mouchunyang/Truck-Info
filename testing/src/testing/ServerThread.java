package testing;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ServerThread extends Thread{
	
	private BufferedReader br;
	private PrintWriter pw;
	private ChatRoom cr;
	
    public ServerThread(Socket s, ChatRoom cr) {
    	try {
    		this.cr = cr;
	    	InputStreamReader isr = new InputStreamReader(s.getInputStream());
			this.br = new BufferedReader(isr);
			this.pw = new PrintWriter(s.getOutputStream());			
			/*
			String line = br.readLine();
			System.out.println("Client sent: " + line);
			pw.println("Thanks for sending me a message!");
			pw.flush();
			
			br.close();
			pw.close();
			s.close();
			ss.close();
			*/
	    	this.start();
        }catch(IOException ioe) {
        	System.out.println("ioe in ServerThrea: " + ioe.getMessage());
        }
    }
    public void run() {
	    try {	
	    	while(true) {
	    		String line = br.readLine();
	    		cr.broadcastLine(line, this);
	    	}
	    }catch (IOException ioe) {
	    	
	    }
    }
    public void sendMessage(String line) {
		pw.println(line);
		pw.flush();
	}
}
