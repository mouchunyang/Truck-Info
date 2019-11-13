package testing;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Vector;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;

public class ChatRoom {
	
	private Vector<ServerThread> serverThreads = new Vector<ServerThread>();
	private Vector<Lock> locks;
	private Vector<Condition> conditions; 
	
	public ChatRoom(int port) {
		//port uniquely identify an application
		try {
			System.out.println("Binding to port " + port);
			ServerSocket ss = new ServerSocket(port);
			System.out.println("Bound to port + " + port);
			while(true) {
				Socket s = ss.accept();
				System.out.println("Connection from " + s.getInetAddress());
				ServerThread st = new ServerThread(s, this);//start the server thread
				serverThreads.add(st);
			}
			//Socket s = ss.accept();
			//System.out.println("Connection from +" + s.getInetAddress());
			
			
		}catch (IOException ioe) {
			System.out.println("ioe " + ioe.getMessage());
		}
	}
	public void broadcastLine(String line, ServerThread currentST) {
		if (line != null && line.length() > 0) {
			System.out.println(line);
			for (ServerThread st: serverThreads) {
				if (st != currentST) {
			        st.sendMessage(line);
				}
			}
		}
	}
	
	
	public static void main(String[] args) {
		ChatRoom cr = new ChatRoom(6790);
	}

}
