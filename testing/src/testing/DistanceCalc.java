package testing;


public class DistanceCalc {
	// given 2 coordinates, calculate the distance in miles using the Haversine formla
	public static double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
			double r = 6372.8; // constant used in Haversine formula
			double dLat = Math.toRadians(lat2 - lat1);
	        double dLon = Math.toRadians(lng2 - lng1);
	        lat1 = Math.toRadians(lat1);
	        lat2 = Math.toRadians(lat2);
	 
	        double a = Math.pow(Math.sin(dLat / 2),2) + Math.pow(Math.sin(dLon / 2),2) * Math.cos(lat1) * Math.cos(lat2);
	        double c = 2 * Math.asin(Math.sqrt(a));
	        return r * c * 0.621; // remove the *0.621 for distance in km
	}
	public static void main (String[] args) {
		System.out.println("Distance between is " + 
				DistanceCalc.calculateDistance(34.022350, -118.285118, 34.033939, -118.229348));
	}
}
