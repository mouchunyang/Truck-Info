package testing;

public class TruckInfo {
	private String truckName;
	private String foodMenu;
	private String beverages;
	private String hours;
	private String address;
	private Float latitude;
	private Float longitude;
	private Float rating;
	public TruckInfo(String truckName, String foodMenu, String beverages, String hours, String address, Float latitude,
			Float longitude, Float rating) {
		this.truckName = truckName;
		this.foodMenu = foodMenu;
		this.beverages = beverages;
		this.hours = hours;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.rating = rating;
	}
	public String getTruckName() {
		return truckName;
	}
	public String getFoodMenu() {
		return foodMenu;
	}
	public String getBeverages() {
		return beverages;
	}
	public String getHours() {
		return hours;
	}
	public String getAddress() {
		return address;
	}
	public Float getLatitude() {
		return latitude;
	}
	public Float getLongitude() {
		return longitude;
	}
	public Float getRating() {
		return rating;
	}
	
}
